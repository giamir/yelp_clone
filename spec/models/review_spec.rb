require 'rails_helper'

describe Review, type: :model do
  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
  it 'is invalid if the user already left a review' do
    user       = create(:user)
    restaurant = create(:restaurant, name: 'KFC', user: user)
    create(:review, restaurant: restaurant, user: user)
    review = Review.new(restaurant: restaurant, user: user)
    expect(review).to have(1).error_on(:user)
  end
end
