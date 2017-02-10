require_relative '../spec_helper.rb'

feature 'User can sign out' do
  scenario 'User can sign out of website' do
    sign_up
    sign_in
    click_on 'sign out'
    expect(page).to have_content "You have now signed out"
  end
  scenario 'sign out button not available if user not logged in' do
    visit '/'
    expect(page).to_not have_content 'sign out'
  end
end
