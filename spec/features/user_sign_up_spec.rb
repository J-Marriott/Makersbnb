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

		scenario 'User account is not created when email is invalid format' do
				visit('/users/new')
				expect(page.status_code).to eq (200)
				fill_in('email', with: 'bill.example.com')
				fill_in('password', with: '123')
				fill_in('password_confirmation', with: '123')
				fill_in('name', with: 'Bill')
				click_button('Submit')
				expect(User.first).to eq(nil)
				expect(page).to have_content 'Sign up unsuccesful'
			end

scenario 'User account is not created passwords not matching' do
				visit('/users/new')
				expect(page.status_code).to eq (200)
				fill_in('email', with: 'bab@example.com')
				fill_in('password', with: '123')
				fill_in('password_confirmation', with: '234')
				fill_in('name', with: 'Bab')
				click_button('Submit')
				expect(User.first).to eq(nil)
			end

	end
