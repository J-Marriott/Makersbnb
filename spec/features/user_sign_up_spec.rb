require_relative '../spec_helper.rb'

	feature 'User is able to sign up' do
		scenario 'User account is created' do
			visit('/users/new')
			expect(page.status_code).to eq (200)
			fill_in('email', with: 'bob@example.com')
			fill_in('password', with: '123')
			fill_in('password_confirmation', with: '123')
			fill_in('name', with: 'Bob')
			click_button('Submit')
			expect(User.first.name).to eq("Bob")
		end

	end