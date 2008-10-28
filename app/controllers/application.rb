# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
#  protect_from_forgery # :secret => '7a9ecd83e12f762f949214ff9b540b58'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  private  
    def msg(msg_text, success=true, error_obj=nil)
      flash[:success]   =   success
      flash[:notice]    =   msg_text
      flash[:error_obj] =   error_obj
    end
  
  
end
