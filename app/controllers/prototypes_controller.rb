class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  private

  def authorize_user!
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end
end