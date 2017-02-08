require_relative '../spec_helper.rb'

feature 'adding new space' do
  scenario 'user can list a new space' do
    sign_up
    sign_in
    visit '/spaces/new'
    expect(page.status_code).to eq(200)
    fill_in 'name', with: 'Bob\'s villa'
    fill_in 'description', with: 'A lovely villa'
    fill_in 'price', with: '£10000'
    fill_in 'available_start_date', with: '19/06/2017'
    fill_in 'available_end_date', with: '25/06/2017'
    click_button 'submit'
    expect(page.current_path).to eq '/'
    expect(Space.first.name).to eq("Bob\'s villa")
  end

end
