# frozen_string_literal: true

# Main Backoffice
class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: %i[edit update destroy]
  after_action :verify_authorized, only: :new
  after_action :verify_policy_scoped, only: :index

  def index
    @admins = policy_scope(Admin)
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path,
                  notice: "Sucesso ao criar: Administrador (#{@admin.email})!"
    else
      render :new
    end
  end

  def edit; end

  def update
    if params_admin.values_at(:password, :password_confirmation).all?(&:blank?)
      admin_params = params_admin.except(%i[password password_confirmation])
    else
      admin_params = params_admin
    end

    if @admin.update(admin_params)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to backoffice_admins_path,
                  notice: "Sucesso ao alterar: Administrador (#{@admin.email})!"
    else
      p @admin.errors.full_messages
      render :edit
    end
  end

  def destroy
    authorize @admin
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
    params.require(:admin).permit(
      :email, :name, :role, :password, :password_confirmation
    )
  end
end
