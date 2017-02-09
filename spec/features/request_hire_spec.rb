require_relative '../spec_helper.rb'

feature 'hire space request' do
  scenario 'logged in user can click link to space' do
    sign_up
    sign_in
    list_space(name: 'Lucy villa', description: 'A lovely villa', price: 10000, available_start_date: '19/06/2017', available_end_date: '25/06/2017')
    visit ('/spaces')
    click_link('Lucy villa A lovely villa')
    expect(page).to have_current_path('/spaces/1')
  end

  scenario 'creates a request for that space and date' do
    sign_up
    sign_in
    list_space(name: 'Lucy villa', description: 'A lovely villa', price: 10000, available_start_date: '19/06/2017', available_end_date: '25/06/2017')
    visit ('/spaces')
    click_link('Lucy villa A lovely villa')
    fill_in('check_in_date', with: '20/06/2017')
    fill_in('check_out_date', with: '21/06/2017')
    click_button('Confirm')
    p Request.first
    expect(Request.first.request_status).to eq('pending')
    #expect(page).to have_content('Thankyou')
  end


end
