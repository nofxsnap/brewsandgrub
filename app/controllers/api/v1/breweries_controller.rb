class Api::V1::BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :update, :destroy]

  # GET /breweries
  def index
    @breweries = Brewery.all
    json_response(@breweries)
  end

  # POST /breweries
  def create
    @brewery = Brewery.create!(brewery_params)
    json_response(@brewery, :created)
  end

  # GET /breweries/:id
  def show
    json_response(@brewery)
  end

  # PUT /breweries/:id
  def update
    @brewery.update(brewery_params)
    json_response(@brewery)
  end

  # DELETE /breweries/:id
  def destroy
    @brewery.destroy
    head :no_content
  end

  private

  def brewery_params
    # whitelist params
    params.require(:brewery).permit(:name, :contact_id, :address_street, :address_city, :address_state,
                  :address_zip, :phone, :email, :website, :logo, :yelp_url, :description)
  end

  def set_brewery
    @brewery = Brewery.find(params[:id])
  end
end
