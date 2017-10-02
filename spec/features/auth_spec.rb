require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Welcome to goals_app'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: 'sicko'
      fill_in 'Password', with: 'password'
      click_on 'Sign Up'
    end

    scenario 'redirects to the goal index page' do
      expect(page).to have_content 'Goal'
    end

    scenario 'shows the right words on the goal index page after signup' do
      expect(page).to have_content 'Your Goals'
    end
  end
end
