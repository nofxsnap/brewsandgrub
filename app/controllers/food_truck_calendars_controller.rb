class FoodTruckCalendarsController < ApplicationController
  before_action :set_food_truck_calendar, only: [:show, :update, :destroy]

  # GET /food_truck_calendars
  def index
    @food_truck_calendars = FoodTruckCalendar.all
    json_response(@food_truck_calendars)
  end

  # POST /food_truck_calendars
  def create
    @food_truck_calendar = FoodTruckCalendar.create!(food_truck_calendar_params)
    json_response(@food_truck_calendar, :created)
  end

  # GET /food_truck_calendars/:id
  def show
    json_response(@food_truck_calendar)
  end

  # PUT /food_truck_calendars/:id
  def update
    @food_truck_calendar.update(food_truck_calendar_params)
    head :no_content
  end

  # DELETE /food_truck_calendars/:id
  def destroy
    @food_truck_calendar.destroy
    head :no_content
  end

  private

  def food_truck_calendar_params
    # whitelist params
    params.permit(:image_url, :owner_id, :owner_type)
  end

  def set_food_truck_calendar
    @food_truck_calendar = FoodTruckCalendar.find(params[:id])
  end
end
