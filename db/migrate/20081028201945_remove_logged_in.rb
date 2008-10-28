class RemoveLoggedIn < ActiveRecord::Migration
  def self.up
    remove_column :users, :is_logged_in
  end

  def self.down
  end
end
