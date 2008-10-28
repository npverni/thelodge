class StatsController < ApplicationController
  before_filter :login_required


  def create
    @stat = current_user.stats.create(params[:stat])
    @success = @stat.save    

    render :juggernaut do |page|
      if @success
        page["stat-#{@stat.user.id}"].replace :partial => 'lounge/stat', :object => @current_user
        page << "$('#new-stat').val('');"
      else
        page.alert ('oops, something bad happened.  did you fill out all the fields?')
      end
    end
      
  end
  
end
