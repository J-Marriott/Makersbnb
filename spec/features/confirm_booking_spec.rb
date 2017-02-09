feature 'booking confirmation' do
  scenario 'user can confirm a booking request' do
    request_setup
    visit '/requests'
    click_button 'Accept'
    expect(Request.first.request_status).to eq 'confirmed'
    expect(page.current_path).to eq '/requests'
  end

    scenario 'user can deny a booking request' do
    request_setup
    visit '/requests'
    click_button 'Deny'
    expect(Request.first.request_status).to eq 'denied'
    expect(page.current_path).to eq '/requests'
  end

end
