require_relative '../spec_helper.rb'

feature 'User can sign out' do
  scenario 'User can sign out of website' do
    sign_up
    sign_in
    click_on 'sign out'
    expect(page).to have_content "Welcome to Makers BnB"
  end
end
