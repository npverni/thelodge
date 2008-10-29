
task :update_from_bot => :environment do
  puts "#{ENV['USERNAME']} #{ENV['MSG']}"
  login = ENV['LOGIN']
  msg =  ENV['MSG']
  u = User.find_by_login(login)
  s = u.stats.new
  s.msg = msg
  s.save
end


task :launch_bot  => :environment do
  require 'net/toc'
  #authorized = ["nathanblend"]
  Net::TOC.new("BlenderboxBot", "curmudg30n") do | message, buddy |
    if true
      begin
        result = message.chomp.gsub(/<[^>]+>/,"")

        u = User.find_by_aim_screenname(buddy.screen_name)
        if u.blank?
          buddy.send_im 'Invalid screenname'
        else
          s = u.stats.new
          s.msg = result
          s.save
          #result = "you said:" + message.chomp.gsub(/<[^>]+>/,"")                        
           response = "have fun with that"
          render :juggernaut do |page|
            if @success
              page["stat-#{s.user.id}"].replace :partial => 'lounge/stat', :object => u
              page << "$('#new-stat').val('');"
            else
              page.alert ('oops, something bad happened.  did you fill out all the fields?')
            end
          end
          buddy.send_im result.to_s if result.respond_to? :to_s
        end
      rescue Exception => e
        buddy.send_im "#{e.class}: #{e}"
      end
    end
  end

end

