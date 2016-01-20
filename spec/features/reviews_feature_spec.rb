require 'rails_helper'

feature 'reviewing' do
  context 'creating reviews' do
    scenario 'allows users to leave a review using a form' do
      user       = create(:user)
      restaurant = create(:restaurant, name: 'KFC', user: user)
      sign_in_as(user)
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end
    scenario 'do not allow users to leave more than one review per restaurant' do
      user       = create(:user)
      restaurant = create(:restaurant, name: 'KFC', user: user)
      create(:review, restaurant: restaurant, user: user)
      sign_in_as(user)
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).to have_content('error')
    end
  end
  context 'deleting reviews' do
    scenario 'removes a review when a user clicks a delete link' do
      user       = create(:user)
      restaurant = create(:restaurant, name: 'KFC', user: user)
      create(:review, thoughts: 'so so', restaurant: restaurant, user: user)
      sign_in_as(user)
      visit '/restaurants'
      click_link 'Delete review'
      expect(page).not_to have_content 'so so'
      expect(page).to have_content 'Review deleted successfully'
    end
    scenario 'throws an error if trying to delete a review I did not author' do
      user = create(:user)
      restaurant = create(:restaurant, name: 'KFC', user: user)
      create(:review, restaurant: restaurant, user: user)
      new_user = create(:user, email: "newuser@email.com")
      sign_in_as(new_user)
      visit '/restaurants'
      click_link 'Delete review'
      expect(page).to have_content 'error'
    end
  end
end
