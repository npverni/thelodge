class LoungeController < ApplicationController
  before_filter :login_required, :except => :test
  
  def index
    @stat = Stat.new
    
    @users = User.logged_in_users
    #@stats = Stat.find_recent_for_users
    
#    render :juggernaut do |page|
#      page.insert_html :top, '#stats', :partial => 'lounge/stat', :object => @current_user
#    end
  end


  def add_user

    render :nothing => true
  end
  
  def test
    render :juggernaut do |page|
      page.alert(    params[:client_id])
    end
  end
  
  def remove_user
    id = current_user.id
    
    render :juggernaut do |page|
      page << "$('#stat-#{id}).remove();"
    end
    render :nothing => true
  end
  
  
end