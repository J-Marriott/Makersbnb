module SMS

  def new_signup_sms
    RestClient.post "https://api:key-ab2b7726eafed9f0b08a4e3908dca88d"\
    "@api.mailgun.net/v3/sandbox81ef4afdfa4c419f8de9ed34c2611bec.mailgun.org/messages",
    :from => "Makers BnB <mailgun@sandbox81ef4afdfa4c419f8de9ed34c2611bec.mailgun.org>",
    :to => 'makersbnbcustomer@gmail.com',
    :subject => 'Welcome to MakersBnB',
    :text => "Thank you for joining MakersBnB"
  end
end
