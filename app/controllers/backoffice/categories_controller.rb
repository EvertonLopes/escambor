# frozen_string_literal: true

class Backoffice::CategoriesController < BackofficeController
  # before_action :set_category, only: [:edit, :update]
  before_action :set_category, only: %i[edit update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(params_category)
    if @category.save
      redirect_to backoffice_categories_path,
                  notice: "Sucesso ao Criar: A categoria (#{@category.description})!"
    else
      render 'new'
    end
  end

  def update
    if @category.update(params_category)
      redirect_to backoffice_categories_path,
                  notice: "Sucesso ao Alterar: A categoria (#{@category.description})!"
    else
      render 'edit'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def params_category
    params.require(:category).permit(:description)
  end
end
