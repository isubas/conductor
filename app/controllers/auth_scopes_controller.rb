# frozen_string_literal: true

class AuthScopesController < ApplicationController
  before_action :set_auth_scope, only: %i[show edit update destroy]

  # GET /auth_scopes
  # GET /auth_scopes.json
  def index
    @auth_scopes = AuthScope.all
  end

  # GET /auth_scopes/1
  # GET /auth_scopes/1.json
  def show; end

  # GET /auth_scopes/new
  def new
    @auth_scope = AuthScope.new(name: 'BookScope')
  end

  # GET /auth_scopes/1/edit
  def edit; end

  # POST /auth_scopes
  # POST /auth_scopes.json
  def create
    @auth_scope = AuthScope.new(name: auth_scope_params[:name])
    @auth_scope.assign_attributes(auth_scope_params)

    respond_to do |format|
      if @auth_scope.save
        format.html { redirect_to @auth_scope, notice: 'Auth scope was successfully created.' }
        format.json { render :show, status: :created, location: @auth_scope }
      else
        format.html { render :new }
        format.json { render json: @auth_scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auth_scopes/1
  # PATCH/PUT /auth_scopes/1.json
  def update
    respond_to do |format|
      if @auth_scope.update(auth_scope_params)
        format.html { redirect_to @auth_scope, notice: 'Auth scope was successfully updated.' }
        format.json { render :show, status: :ok, location: @auth_scope }
      else
        format.html { render :edit }
        format.json { render json: @auth_scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auth_scopes/1
  # DELETE /auth_scopes/1.json
  def destroy
    @auth_scope.destroy
    respond_to do |format|
      format.html { redirect_to auth_scopes_url, notice: 'Auth scope was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_auth_scope
    @auth_scope = AuthScope.find(params[:id])
  end

  def auth_scope_params
    @auth_scope ||= AuthScope.new(name: params[:auth_scope][:name])
    params.require(:auth_scope).permit(
      :name, :user_id, *@auth_scope.permited_attributes_for_values
    )
  end
end
