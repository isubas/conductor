# frozen_string_literal: true

class QueryStoresController < ApplicationController
  before_action :set_query_store, only: %i[show edit update destroy]

  # GET /query_stores
  # GET /query_stores.json
  def index
    @query_stores = QueryStore.all
  end

  # GET /query_stores/1
  # GET /query_stores/1.json
  def show; end

  # GET /query_stores/new
  def new
    @query_store = QueryStore.new(name: 'BookScope')
  end

  # GET /query_stores/1/edit
  def edit; end

  # POST /query_stores
  # POST /query_stores.json
  def create
    @query_store = QueryStore.new(name: query_store_params[:name])
    @query_store.assign_attributes(query_store_params)

    respond_to do |format|
      if @query_store.save
        format.html { redirect_to @query_store, notice: 'Auth scope was successfully created.' }
        format.json { render :show, status: :created, location: @query_store }
      else
        format.html { render :new }
        format.json { render json: @query_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /query_stores/1
  # PATCH/PUT /query_stores/1.json
  def update
    respond_to do |format|
      if @query_store.update(query_store_params)
        format.html { redirect_to @query_store, notice: 'Auth scope was successfully updated.' }
        format.json { render :show, status: :ok, location: @query_store }
      else
        format.html { render :edit }
        format.json { render json: @query_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /query_stores/1
  # DELETE /query_stores/1.json
  def destroy
    @query_store.destroy
    respond_to do |format|
      format.html { redirect_to query_stores_url, notice: 'Auth scope was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_query_store
    @query_store = QueryStore.find(params[:id])
  end

  def query_store_params
    @query_store ||= QueryStore.new(name: params[:query_store][:name])
    params.require(:query_store).permit(
      :name, :user_id, *@query_store.permitted_attributes.to_a
    )
  end
end
