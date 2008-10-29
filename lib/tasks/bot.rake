
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
  authorized = ["nathanblend"]
  Net::TOC.new("BlenderboxBot", "curmudg30n") do | message, buddy |
    if authorized.member? buddy.screen_name
      begin
        result = message.chomp.gsub(/<[^>]+>/,"")
        u = User.find_by_login(buddy.screen_name)
        s = u.stats.new
        s.msg = result
        s.save
        #result = "you said:" + message.chomp.gsub(/<[^>]+>/,"")        
        response = "have fun with that"
        
        Juggernaut.send_to_all("$('#msg-#{u.id}').html('#{s.msg}');")
        
        
        buddy.send_im response if result.respond_to? :to_s
      rescue Exception => e
        buddy.send_im "#{e.class}: #{e}"
      end
    end
  end

end

