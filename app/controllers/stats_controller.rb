class StatsController < ApplicationController
  before_filter :login_required


  def create
    @stat = current_user.stats.create(params[:stat])
    @success = @stat.save
    
    respond_to do |format|
      format.js
    end
  end
  

end
