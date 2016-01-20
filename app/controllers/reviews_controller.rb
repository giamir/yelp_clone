class ReviewsController < ApplicationController
  include ReviewsHelper
  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    return redirect_to restaurants_path if @review.save
    if @review.errors[:user]
      flash[:notice] = 'error: you have already reviewed this restaurant'
      return redirect_to restaurants_path
    end
    return render :new
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user.reviews.include? @review
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
    else
      flash[:notice] = "error: you are not the author of the entry for this review"
    end
    redirect_to restaurants_path
  end
end
