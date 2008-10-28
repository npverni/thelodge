class LoungeController < ApplicationController
  before_filter :login_required
  
  def index
    @stat = Stat.new
    
    @users = User.logged_in_users
    #@stats = Stat.find_recent_for_users
  end


  def add_user
    render :juggernaut do |page|
      page.insert_html :top, '#stats', :partial => 'lounge/stat', :object => @current_user
    end
    render :nothing => true
  end
  
  def remove_user
    id = current_user.id
    current_user.is_logged_in = false
    current_user.save
    
    render :juggernaut do |page|
      page << "$('#stat-#{id}).remove();"
    end
    render :nothing => true
  end
end