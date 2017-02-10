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
    expect(page).to have_content('Properties available from 2017-04-01 to 2017-06-30')
  end

  scenario 'user can enter a date range and return just one result' do
    sign_up
    sign_in
    user = User.create(name: 'Vince', email: 'vince@example.com')
    space = Space.create(name: 'Vintage before date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-01-01', available_end_date: '2017-04-31', user_id: 2)
    space = Space.create(name: 'Vintage in date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-30', user_id: 2)
    space = Space.create(name: 'Vintage after date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-07-01', available_end_date: '2017-12-31', user_id: 2)
    fill_in('first_night', with:'2017-04-02' )
    fill_in('last_night', with: '2017-04-11')
    click_on('submit')
    expect(page).to have_content('Vintage in date range')
    expect(page).to_not have_content('Vintage before data range')
    expect(page).to_not have_content('Vintage after date range')
  end

  scenario 'user can enter a date range and return just one result - with stricter date test' do
    sign_up
    sign_in
    user = User.create(name: 'Vince', email: 'vince@example.com')
    space = Space.create(name: 'Vintage before date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-10', user_id: 2)
    space = Space.create(name: 'Vintage in date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-30', user_id: 2)
    space = Space.create(name: 'Vintage after date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-07', available_end_date: '2017-04-09', user_id: 2)
    fill_in('first_night', with:'2017-04-02' )
    fill_in('last_night', with: '2017-04-11')
    click_on('submit')
    expect(page).to have_content('Vintage in date range')
    expect(page).to_not have_content('Vintage before data range')
    expect(page).to_not have_content('Vintage after date range')
  end

  scenario 'user can enter a date range and no property as the only available is booked by others in the range' do
    sign_up
    sign_in
    user = User.create(name: 'Vince', email: 'vince@example.com')
    space = Space.create(name: 'Vintage before date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-10', user_id: 2)
    space = Space.create(name: 'Vintage in date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-30', user_id: 2)
    space = Space.create(name: 'Vintage after date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-07', available_end_date: '2017-04-09', user_id: 2)
    request = Request.create(user_id: 3, space_id: 2, check_in_date: '2017-04-03', check_out_date: '2017-04-07', request_status: 'confirmed')
    request = Request.create(user_id: 3, space_id: 2, check_in_date: '2017-04-08', check_out_date: '2017-04-09', request_status: 'confirmed')
    fill_in('first_night', with:'2017-04-02' )
    fill_in('last_night', with: '2017-04-11')
    click_on('submit')
    expect(page).to_not have_content('Vintage in date range')
    expect(page).to_not have_content('Vintage before data range')
    expect(page).to_not have_content('Vintage after date range')
  end

  scenario 'user can see available property and unavailable ones are hidden' do
    sign_up
    sign_in
    user = User.create(name: 'Vince', email: 'vince@example.com')
    space = Space.create(name: 'Vintage before date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-10', user_id: 2)
    space = Space.create(name: 'Vintage in date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-30', user_id: 2)
    space = Space.create(name: 'Vintage after date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-07', available_end_date: '2017-04-09', user_id: 2)
    space = Space.create(name: 'Within date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-14', user_id: 2)
    request = Request.create(user_id: 3, space_id: 2, check_in_date: '2017-04-03', check_out_date: '2017-04-07', request_status: 'confirmed')
    request = Request.create(user_id: 3, space_id: 2, check_in_date: '2017-04-08', check_out_date: '2017-04-09', request_status: 'confirmed')
    fill_in('first_night', with:'2017-04-02' )
    fill_in('last_night', with: '2017-04-11')
    click_on('submit')
    expect(page).to_not have_content('Vintage in date range')
    expect(page).to_not have_content('Vintage before data range')
    expect(page).to_not have_content('Vintage after date range')
    expect(page).to have_content('Within date range')
  end

  scenario 'stress test' do
    sign_up
    sign_in
    user = User.create(name: 'Vince', email: 'vince@example.com')
    100.times do
    space = Space.create(name: 'Vintage before date range', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-04-01', available_end_date: '2017-04-10', user_id: 2)
    end
    request = Request.create(user_id: 3, space_id: 2, check_in_date: '2017-04-03', check_out_date: '2017-04-07', request_status: 'confirmed')
    request = Request.create(user_id: 3, space_id: 92, check_in_date: '2017-04-08', check_out_date: '2017-04-09', request_status: 'confirmed')
    fill_in('first_night', with:'2017-04-02' )
    fill_in('last_night', with: '2017-04-11')
    click_on('submit')
    expect(page).to_not have_content('Vintage before data range')
    fill_in('first_night', with:'2017-04-02' )
    fill_in('last_night', with: '2017-04-07')
    click_on('submit')
    expect(page).to_not have_content('Vintage in date range')
  end


end
