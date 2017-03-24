class Api::V1::MenusController < ApplicationController
  before_action :set_menu, only: [:show, :update, :destroy]

  # GET /menus
  def index
    @menus = Menu.all
    json_response(@menus)
  end

  # POST /menus
  def create
    @menu = Menu.create!(menu_params)
    json_response(@menu, :created)
  end

  # GET /menus/:id
  def show
    json_response(@menu)
  end

  # PUT /menus/:id
  def update
    @menu.update(menu_params)
    json_response(@menu)
  end

  # DELETE /menus/:id
  def destroy
    @menu.destroy
    head :no_content
  end

  private

  def menu_params
    # whitelist params
    params.permit(:image_url, :owner_id, :owner_type)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
