require 'rails_helper'

describe 'User Sessions', type: :feature do
  before :each do
    if User.all.empty?
      User.create(name: 'Registered')
    end
    visit sign_in_path
  end

  context 'user not signed in' do
    before do
      fill_in 'Name', with: 'notUser'
      click_button 'Sign in'
    end

    it 'displays an error message' do
      expect(page).to have_content('User not found, try again')
    end

    it 'shows the correct menu links' do
      within('.nav-bar') do
        expect(page).to have_link('LOGIN')
        expect(page).to have_link('REGISTER')
        expect(page).to_not have_link('LOGOUT')
      end
    end
  end

  context 'user signed in' do
    before do
      fill_in 'Name', with: "Registered"
      click_button 'Sign in'
    end

    it 'displays a welcome message' do
      expect(page).to have_content('Welcome')
    end

    it 'shows the correct menu links' do
      within('.nav-bar') do
        expect(page).to_not have_link('LOGIN')
        expect(page).to_not have_link('REGISTER')
        expect(page).to have_link('LOGOUT')
      end
    end
  end
end
