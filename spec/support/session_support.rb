def logout
  visit destroy_user_session_path
end

def login_as user, password = 'password'
  visit login_path
  fill_in 'user_email',    with: user.email
  fill_in 'user_password', with: password
  click_button 'Sign in'
end

def login_admin user, password = 'password'
  visit new_admin_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Login'
end

