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
    fill_in('check_in_date', with: '2017-06-20')
    fill_in('check_out_date', with: '2017-06-21')
    click_button('Confirm')
    expect(Request.first.space_id).to eq(1)
  end

    scenario 'cannot create a request if user is not logged in' do
    sign_up
    sign_in
    list_space(name: 'Lucy villa', description: 'A lovely villa', price: 10000, available_start_date: '19/06/2017', available_end_date: '25/06/2017')
    sign_out
    visit ('/spaces')
    click_link('Lucy villa A lovely villa')
    fill_in('check_in_date', with: '2017-06-20')
    fill_in('check_out_date', with: '2017-06-21')
    click_button('Confirm')
    expect(Request.all).to be_empty
    end

    scenario 'cannot create a request if check in and check out date are before the availability date' do
    sign_up
    sign_in
    list_space(name: 'Lucy villa', description: 'A lovely villa', price: 10000, available_start_date: '19/06/2017', available_end_date: '25/06/2017')
    visit ('/spaces')
    click_link('Lucy villa A lovely villa')
    fill_in('check_in_date', with: '2017-05-20')
    fill_in('check_out_date', with: '2017-05-21')
    click_button('Confirm')
    expect(Request.all).to be_empty
    end

    scenario 'cannot create a request if check in and check out date after the availability date' do
    sign_up
    sign_in
    list_space(name: 'Lucy villa', description: 'A lovely villa', price: 10000, available_start_date: '19/06/2017', available_end_date: '25/06/2017')
    visit ('/spaces')
    click_link('Lucy villa A lovely villa')
    fill_in('check_in_date', with: '2017-07-01')
    fill_in('check_out_date', with: '2017-07-02')
    click_button('Confirm')
    expect(Request.all).to be_empty
    end

    scenario 'cannot create a request if the check out date is before the check in date' do
      sign_up
      sign_in
      list_space(name: 'Lucy villa', description: 'A lovely villa', price: 10000, available_start_date: '19/06/2017', available_end_date: '25/07/2017')
      visit ('/spaces')
      click_link('Lucy villa A lovely villa')
      fill_in('check_in_date', with: '2017-07-02')
      fill_in('check_out_date', with: '2017-07-01')
      click_button('Confirm')
      expect(Request.all).to be_empty
    end

end
