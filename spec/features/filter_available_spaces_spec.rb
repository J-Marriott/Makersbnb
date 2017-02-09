require_relative '../spec_helper'

feature 'display available spaces' do
  scenario 'user can enter a date range' do
    sign_up
    sign_in
    user = User.create(name: 'Vince', email: 'vince@example.com')
    space = Space.create(name: 'Vintage before date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-01-01', available_end_date: '2017-03-31', user_id: 2)
    space = Space.create(name: 'Vintage in date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-06-30', user_id: 2)
    space = Space.create(name: 'Vintage after date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-07-01', available_end_date: '2017-12-31', user_id: 2)
    fill_in('first_night', with:'2017-04-01' )
    fill_in('last_night', with: '2017-06-30')
    click_on('submit')
    #expect fields to contain first_night and last_night
    expect(page).to have_content('first night last night Vintage before date range ')
  end
end
