# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def msg_box(txt=nil)
    txt ||= flash[:notice]
    html = ""
    unless txt.blank?
      if txt.split("error_on=")[1]
        txt = error_messages_for txt.split("error_on=")[1].to_sym
      end
      unless txt.blank?
        html = "<div id='errors'><div id=\"flash\" class=\"msg #{flash[:success] == false ? 'error' : 'success'}\"><p>#{flash[:notice]}</p></div></div>"
      end
    end
    flash[:notice] = nil    
    html
  end


end