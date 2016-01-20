class RestaurantsController < ApplicationController
  include RestaurantsHelper
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless current_user.restaurants.include? @restaurant
      flash[:notice] = 'error: you must be the author to edit a restaurant'
      redirect_to restaurants_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.restaurants.include? @restaurant
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:notice] = "error: you are not the author of the entry for #{@restaurant.name}"
    end
    redirect_to restaurants_path
  end
end
