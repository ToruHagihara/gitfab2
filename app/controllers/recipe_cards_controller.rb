class RecipeCardsController < ApplicationController
  before_action :load_owner
  before_action :load_project
  before_action :load_recipe
  before_action :build_recipe_card, only: :create
  before_action :load_recipe_card, only: [:edit, :update, :destroy]

  def new
  end

  def edit
  end

  def create
    if @recipe_card.save
      render :create
    else
      render "errors/failed", status: 400
    end
  end

  def update
    if @recipe_card.update recipe_card_params
      render :update
    else
      render "errors/failed", status: 400
    end
  end

  private
  def load_owner
    owner_id = params[:owner_name] || params[:user_id] || params[:group_id]
    @owner = User.find(owner_id) || Group.find(owner_id)
  end

  def load_project
    @project = @owner.projects.find params[:project_id]
  end

  def load_recipe
    @recipe = @project.recipe
  end

  def build_recipe_card
    @recipe_card = @recipe.recipe_cards.build recipe_card_params
  end

  def load_recipe_card
    @recipe_card = @recipe.recipe_cards.find params[:id]
  end

  def recipe_card_params
    if params[:recipe_card]
      w_list = Card::RecipeCard.updatable_columns
      w_list << {derivatives_attributes: Card::RecipeCard.updatable_columns}
      params.require(:recipe_card).permit w_list
    end
  end
end