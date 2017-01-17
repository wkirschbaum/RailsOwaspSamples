# app/controllers/users_controller.rb

def update
  message = false
  # fix SQL injection attack:
  user = User.find(params[:user][:user_id])
  # only allow user to change their own password
  if user == current_user
    user.skip_user_id_assign = true
    user.skip_hash_password = true
    user.update_attributes(user_params_without_password)
    if !(params[:user][:password].empty?) && (params[:user][:password] == params[:user][:password_confirmation])
      user.skip_hash_password = false
      user.password = params[:user][:password]
    end
    message = true if user.save!
    respond_to do |format|
      format.html { redirect_to user_account_settings_path(:user_id => current_user.user_id) }
      format.json { render :json => {:msg => message ? "success" : "false "} }
    end
  else
    flash[:error] = "Could not update user!"
    redirect_to user_account_settings_path(:user_id => current_user.user_id)
  end
end


