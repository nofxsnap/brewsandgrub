class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy]

  # GET /ratings
  def index
    @ratings = Rating.all
    json_response(@ratings)
  end

  # POST /ratings
  def create
    @rating = Rating.create!(rating_params)
    json_response(@rating, :created)
  end

  # GET /ratings/:id
  def show
    json_response(@rating)
  end

  # PUT /ratings/:id
  def update
    @rating.update(rating_params)
    head :no_content
  end

  # DELETE /ratings/:id
  def destroy
    @rating.destroy
    head :no_content
  end

  private

  def rating_params
    # whitelist params
    params.permit(:owner_id, :owner_type, :rating)
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end
end
