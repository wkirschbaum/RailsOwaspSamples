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
      cookies.permanent[:auth_token] = user.auth_token if User.where(:user_id => user.user_id).exists?
    else
      session[:user_id] = user.user_id if User.where(:user_id => user.user_id).exists?
    end
    redirect_to path
  else
    # Removed this code, just doesn't seem specific enough!
    # flash[:error] = "Either your username and password is incorrect"
    flash[:error] = e.message
    render "new"
  end
end
