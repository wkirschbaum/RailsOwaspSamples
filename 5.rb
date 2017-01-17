# /app/models/user.rb

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

# /app/controllers/sessions_controller.rb

def create
  path = params[:url].present? ? params[:url] : home_dashboard_index_path
  begin
    # Normalize the email address, why not
    user = User.authenticate(params[:email].to_s.downcase, params[:password])
  # @url = params[:url]
  rescue Exception => e
  end
  if user
    if params[:remember_me]
      cookies[:auth_token] = {
          value: user.auth_token,
          expires: 2.weeks.from_now
      }
    else
      session[:user_id] = user.user_id
    end
    redirect_to path
  else
    # Do not make this more specific! It will expose information about which
    # users exist.
    flash[:error] = "Either your username or password or both are incorrect"
    render "new"
  end
end
