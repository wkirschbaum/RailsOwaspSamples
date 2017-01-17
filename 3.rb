# app/controllers/benefits_controller.rb

def upload
  file = params[:benefits][:upload]
  if file
    flash[:success] = "File Successfully Uploaded!"
    Benefits.save(file, params[:benefits][:backup] == "true")
  else
    flash[:error] = "Something went wrong"
  end
  redirect_to user_benefit_forms_path(:user_id => current_user.user_id)
end

# app/models/benefits.rb

class Benefits < ActiveRecord::Base
  attr_accessor :backup

  def self.save(file, backup=false)
    data_path = Rails.root.join("public", "data")
    base_name = File.basename(file.original_filename)
    full_file_name = "#{data_path}/#{base_name}"
    f = File.open(full_file_name, "wb+")
    f.write file.read
    f.close
    make_backup(base_name, data_path, full_file_name) if backup
  end

  def self.make_backup(base_name, data_path, full_file_name)
    if File.exists?(full_file_name)
      silence_streams(STDERR) { system(
          "/bin/cp",
          full_file_name,
          "#{data_path}/bak#{Time.zone.now.to_i}_#{base_name}"
      ) }
    end
  end

end
