class FoodTrucksController < ApplicationController
  before_action :set_food_truck, only: [:show, :update, :destroy]

  # GET /food_trucks
  def index
    @food_trucks = FoodTruck.all
    json_response(@food_trucks)
  end

  # POST /food_trucks
  def create
    @food_truck = FoodTruck.create!(food_truck_params)
    json_response(@food_truck, :created)
  end

  # GET /food_trucks/:id
  def show
    json_response(@food_truck)
  end

  # PUT /food_trucks/:id
  def update
    @food_truck.update(food_truck_params)
    head :no_content
  end

  # DELETE /food_trucks/:id
  def destroy
    @food_truck.destroy
    head :no_content
  end

  private

  def food_truck_params
    # whitelist params
    params.permit(:name, :contact_id, :email, :website, :logo, :yelp_url, :description)
  end

  def set_food_truck
    @food_truck = FoodTruck.find(params[:id])
  end
end
