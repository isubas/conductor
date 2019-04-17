# frozen_string_literal: true

class QueryStoresController < ApplicationController
  before_action :set_query_store, only: %i[show edit update destroy preview]

  def index
    @query_stores = QueryStore.all
  end

  def show; end

  def new
    @query_store = QueryStore.new(name: params[:scope])
  end

  def edit; end

  def create
    @query_store = QueryStore.new(name: query_store_params[:name])
    @query_store.assign_attributes(query_store_params)
    respond_to do |format|
      if @query_store.save
        format.html { redirect_to @query_store, notice: 'Auth scope was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @query_store.update(query_store_params)
        format.html { redirect_to @query_store, notice: 'Auth scope was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @query_store.destroy
    respond_to do |format|
      format.html { redirect_to query_stores_url, notice: 'Auth scope was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    @scope      = @query_store.scope_instance
    @collection = @query_store.scope_for_preview
    @attributes = @query_store.scope_klass.preview_attributes
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
