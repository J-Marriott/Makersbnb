require_relative '../spec_helper.rb'

feature 'User signing in' do
	scenario 'user signed in successfully' do
	sign_up
	sign_in
	expect(page).to have_current_path('/spaces')
	end

	scenario 'user signed in unsuccessfully if password is wrong' do
	sign_up
	sign_in(password: '12356')
	expect(page).to have_current_path('/sessions/new')
	end

	scenario 'user signed in unsuccessfully if no user created' do
	sign_in
	expect(page).to have_current_path('/sessions/new')
	end

end