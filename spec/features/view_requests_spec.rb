require_relative '../spec_helper.rb'

feature 'display a list of spaces' do
  scenario 'user can see request for space' do
    request_setup
    visit '/requests'
    expect(page).to have_content '2017-11-19'
    expect(page).to have_content '2017-11-21'
    expect(page).to have_content 'Vintage London flat'
    expect(page).to have_content 'Vince'
  end

  scenario 'user can see list of requests for space' do
    request_setup
    space1 = Space.create(name: 'Vintage Bristol flat', description: 'Shabby chic flat in Bristol', price: 50, available_start_date: '2017-02-08', available_end_date: '2017-02-12', user_id: 1)
    user1 = User.create(name: 'Shawn', email: 'shawn@example.com')
    request1 = Request.create(check_in_date: '19/12/2017', check_out_date: '21/12/2017', request_status: 'pending', user_id: user1.id, space_id: space1.id)
    visit '/requests'
    expect(page).to have_content '2017-11-19'
    expect(page).to have_content '2017-11-21'
    expect(page).to have_content 'Vintage London flat'
    expect(page).to have_content 'Vince'
    expect(page).to have_content '2017-12-19'
    expect(page).to have_content '2017-12-21'
    expect(page).to have_content 'Vintage Bristol flat'
    expect(page).to have_content 'Shawn'
  end

  scenario 'user can only see requests for spaces listed by user' do
    sign_up
    sign_in
    space = Space.create(name: 'Vintage London flat', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-02-08', available_end_date: '2017-02-12', user_id: 2)
    user = User.create(name: 'Vince', email: 'vince@example.com')
    request = Request.create(check_in_date: '19/11/2017', check_out_date: '21/11/2017', request_status: 'pending', user_id: user.id, space_id: space.id)
    visit '/requests'
    expect(page).to_not have_content '2017-11-19'
    expect(page).to_not have_content 'Vintage London flat'
    expect(page).to_not have_content 'Vince'
  end

end
