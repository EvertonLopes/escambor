# frozen_string_literal: true

class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[new destroy]
  after_action :verify_policy_scoped, only: :index

  def index
    # @admins = Admin.all
    # @admins = Admin.with_restricted_access
    @admins = policy_scope(Admin)
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def edit; end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path,
                  notice: "Sucesso ao criar: Administrador (#{@admin.email})!"
    else
      render :new
    end
  end

  def update
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path,
                  notice: "Sucesso ao alterar: Administrador (#{@admin.email})!"
    else
      render :edit
    end
  end

  def destroy
    auhotize @admin
    admin_email = @admin.email
    if @admin.destroy
      redirect_to backoffice_admins_path,
                  notice: "Sucesso ao excluír: Administrador (#{admin_email})!"
    else
      render :index
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    passwd = params[:admin][:password]
    passwd_confirmation = params[:admin][:password_confirmation]

    check_password_blank(passwd, passwd_confirmation)

    params.require(:admin).permit(policy(@admin).permitted_attributes)
  end

  def check_password_blank(pword, pword_confirm)
    if pword.blank? && pword_confirm.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end
  end
end
