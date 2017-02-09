

feature 'booking confirmation' do
  scenario 'user can confirm a booking request' do

    request_setup
    visit '/requests'
    click_button 'submit'

    expect(Booking.first.check_in_date.to_s).to eq '2017-11-19'
    expect(page.current_path).to eq '/requests'
  end

end
