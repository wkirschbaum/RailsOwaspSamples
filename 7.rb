# app/models/user.rb

def self.authenticate(email, password)
  auth = nil
  user = find_by_email(email)
  raise "#{email} doesn't exist!" if !(user)
  if user.password == Digest::MD5.hexdigest(password)
    auth = user
  else
    raise "Incorrect Password!"
  end
  return auth
end
