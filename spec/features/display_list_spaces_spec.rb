require_relative '../spec_helper'

feature 'Display a list of spaces' do
	scenario 'User can see a list of spaces' do
	Space.create(name: 'Vintage London flat', description: 'Shabby chic flat in Mayfair', price: 50, available_start_date: '2017-02-08', available_end_date: '2017-02-12', user_id: 1)
	visit('/spaces')
	expect(page).to have_content('Vintage London flat')
	end
end