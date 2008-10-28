class Stat < ActiveRecord::Base
  
  validates_presence_of :msg

  belongs_to :user


  def self.find_recent_for_users
    @users = User.find(:all,:include => 'stats',:order => :login)
    @stats = @users.map do |u|
      u.stats.first if u.stats.any?
    end
    @stats.compact!
  end
end
