require_relative '../spec_helper.rb'

feature 'hire space request' do
  scenario 'logged in user can send a request to hire space' do
    sign_up
    sign_in
    list_space
    visit ('/spaces')
    click_link('Bob\'s villa')
    expect(page).to have_current_path('/requests/1')
  end
end
