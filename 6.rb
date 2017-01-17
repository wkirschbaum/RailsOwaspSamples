# app/models/user.rb

validates :password, :presence => true,
          :confirmation => true,
          :length => {:within => 6..40}
