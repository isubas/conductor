# frozen_string_literal: true

class ControllerActionsController < ApplicationController
  before_action :set_controller_action, only: %i[show edit update destroy]
  before_action :authorize

  # GET /controller_actions
  # GET /controller_actions.json
  def index
    @controller_actions = ControllerAction.all
  end

  # GET /controller_actions/1
  # GET /controller_actions/1.json
  def show; end

  # GET /controller_actions/new
  def new
    @controller_action = ControllerAction.new
  end

  # GET /controller_actions/1/edit
  def edit; end

  # POST /controller_actions
  # POST /controller_actions.json
  def create
    @controller_action = ControllerAction.new(controller_action_params)

    respond_to do |format|
      if @controller_action.save
        format.html { redirect_to @controller_action, notice: 'Controller action was successfully created.' }
        format.json { render :show, status: :created, location: @controller_action }
      else
        format.html { render :new }
        format.json { render json: @controller_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controller_actions/1
  # PATCH/PUT /controller_actions/1.json
  def update
    respond_to do |format|
      if @controller_action.update(controller_action_params)
        format.html { redirect_to @controller_action, notice: 'Controller action was successfully updated.' }
        format.json { render :show, status: :ok, location: @controller_action }
      else
        format.html { render :edit }
        format.json { render json: @controller_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controller_actions/1
  # DELETE /controller_actions/1.json
  def destroy
    @controller_action.destroy
    respond_to do |format|
      format.html { redirect_to controller_actions_url, notice: 'Controller action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_controller_action
    @controller_action = ControllerAction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def controller_action_params
    params.require(:controller_action).permit(:action, :controller)
  end
end
