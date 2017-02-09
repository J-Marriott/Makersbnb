feature 'User can view request made' do
	scenario 'user can see a request made' do
	sign_up
	sign_in
	list_space
	sign_out
	sign_up(email: 'mabel@example.com')
	sign_in(email: 'mabel@example.com')
	visit('/spaces')
	click_link('Bob\'s villa A lovely villa')
	fill_in('check_in_date', with: '2017-06-20')
	fill_in('check_out_date', with: '2017-06-21')
	click_button('Confirm')
	visit('/requests')
	expect(page).to have_content('Bob\'s villa')
	end
end