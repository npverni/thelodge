class UsersController < ApplicationController
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in

      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def show
    login_required
    @user = User.find(params[:id],:include => :stats)
  end
  
  def edit
    login_required
    @user = current_user
  end
  
  def update
    login_required
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Your account was successfully updated.'
        format.html { redirect_to '/' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
