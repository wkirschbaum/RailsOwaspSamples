# If you changed this code already in 5, please ignore.

# app/models/user.rb

def self.authentication_error
  return "Either your username or password or both are incorrect"
end

def self.authenticate(email, password)
  auth = nil
  user = find_by_email(email)
  raise self.authentication_error if !(user)
  if user.password == Digest::MD5.hexdigest(password)
    auth = user
  else
    raise self.authentication_error
  end
  return auth
end
