def login(email, password)
  visit login_path
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_on (I18n.t :signin)
end

def default_login
  login("foo@bar.com", "foobar")
end
