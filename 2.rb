# app/models/analytics.rb

class Analytics < ActiveRecord::Base
  attr_accessible :ip_address, :referrer, :user_agent

  scope :hits_by_ip, ->(ip,col="*") { select("#{col}").where(:ip_address => ip).order("id DESC")}

  def self.count_by_col(col)
    calculate(:count, col)
  end

  # ...
end

# app/controllers/admin_controller.rb

def analytics
  if params[:field].nil?
    fields = "*"
  else
    fields = params[:field].map {|k,v| k }.join(",")
  end

  if params[:ip]
    @analytics = Analytics.hits_by_ip(params[:ip], fields)
  else
    @analytics = Analytics.all
  end
  render "layouts/admin/_analytics"
end
