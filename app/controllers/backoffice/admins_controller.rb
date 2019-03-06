# frozen_string_literal: true

class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: %i[edit update destroy]

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
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
    passwd = params[:admin][:password]
    passwd_confirmation = params[:admin][:password_confirmation]

    if passwd.blank? && passwd_confirmation.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(params_admin)
      redirect_to backoffice_admins_path,
                  notice: "Sucesso ao alterar: Administrador (#{@admin.email})!"
    else
      render :edit
    end
  end

  def destroy
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
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
