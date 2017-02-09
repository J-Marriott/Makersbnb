def sign_up(email: 'bob@example.com',
           name: 'Bob',
           password: '123',
           password_confirmation: '123')
 visit '/users/new'
 fill_in 'email', with: email
 fill_in 'name', with: name
 fill_in 'password', with: password
 fill_in 'password_confirmation', with: password_confirmation
 click_button 'Submit'
end

def sign_in(email: 'bob@example.com',
           password: '123')
 visit '/sessions/new'
 fill_in 'email', with: email
 fill_in 'password', with: password
 click_button 'Submit'
end

def list_space(name: 'Bob\'s villa',
              description: 'A lovely villa',
              price: 10000,
              available_start_date: '19/06/2017',
              available_end_date: '25/06/2017')
  visit '/spaces/new'
  expect(page.status_code).to eq(200)
  fill_in 'name', with: name
  fill_in 'description', with: description
  fill_in 'price', with: price
  fill_in 'available_start_date', with: available_start_date
  fill_in 'available_end_date', with: available_end_date
  click_button 'submit'
end

def request_setup
  sign_up
  sign_in
  space = Space.create(name: 'Vintage London flat', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-02-08', available_end_date: '2017-02-12', user_id: 1)
  user = User.create(name: 'Vince', email: 'vince@example.com')
  request = Request.create(check_in_date: '19/11/2017', check_out_date: '21/11/2017', request_status: 'pending', user_id: user.id, space_id: space.id)
end
