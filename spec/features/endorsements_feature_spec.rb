require 'rails_helper'

feature 'endorsing reviews' do

  # scenario 'a user can endorse a review, which updates the review endorsement count' do
  #   visit '/restaurants'
  #   click_link 'Endorse review'
  #   expect(page).to have_content('1 endorsement')
  # end

  scenario 'a user can endorse a review, which increments the endorsement count', js: true do
    user = create(:user, email: 'email@email.com')
    restaurant = create(:restaurant)
    create(:review, restaurant: restaurant, user: user)
    visit "/restaurants/#{restaurant.id}"
    click_link 'Endorse review'
    expect(page).to have_content("1 endorsement")
  end

end
