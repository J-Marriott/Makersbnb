require_relative '../spec_helper.rb'

feature 'Visiting homepage' do
  scenario 'User is directed to home page' do
    visit '/'
    expect(page).to have_content "Welcome to Makers BnB"
  end
end
