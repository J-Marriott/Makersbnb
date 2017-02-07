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