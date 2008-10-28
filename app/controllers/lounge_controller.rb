class LoungeController < ApplicationController
  before_filter :login_required
  
  def index
    @stat = Stat.new
    
    @users = User.logged_in_users
    #@stats = Stat.find_recent_for_users
  end

end