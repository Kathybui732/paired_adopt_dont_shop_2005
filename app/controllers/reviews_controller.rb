class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
  @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    new_review = shelter.reviews.create(review_params)
    redirect_to("/shelters/#{shelter.id}")
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture, :shelter_id)
  end
end
