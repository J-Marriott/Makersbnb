require_relative '../spec_helper.rb'

feature 'display a list of spaces' do
  scenario 'user sees a list of spaces' do
    space = Space.create(name: 'Vintage London flat', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-02-08', available_end_date: '2017-02-12', user_id: 1)
    user = User.create(name: 'Bob', email: 'bob@example.com')
    request = Request.create(check_in_date: '19/11/2017', check_out_date: '21/11/2017', request_status: 'pending', user_id: user.id, space_id: space.id)
    p request
    visit '/requests'
    expect(page).to have_content '2017-11-19'
    expect(page).to have_content 'Vintage London flat'

  end
end
