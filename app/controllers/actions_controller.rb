class ActionsController < ApplicationController
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  def index
    @actions = Action.all
  end

  def show
  end

  def new
    @action = Action.new()
  end

  def edit
  end

  def create
    @action = Action.new(action_params)

    respond_to do |format|
      if @action.save
        format.html { redirect_to @action, notice: 'Action was successfully created.' }
        format.json { render :show, status: :created, location: @action }
      else
        format.html { render :new }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @action.update(action_params)
        format.html { redirect_to @action, notice: 'Action was successfully updated.' }
        format.json { render :show, status: :ok, location: @action }
      else
        format.html { render :edit }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @action.destroy
    respond_to do |format|
      format.html { redirect_to actions_url, notice: 'Action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_action
    @action = Action.find(params[:id])
  end

  def action_params
    binding.pry
    params.require(:action).permit(:name, :controller)
  end
end
