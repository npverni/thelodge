class AddLoggedInToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_logged_in, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_logge_in
  end
end
