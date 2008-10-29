class AddScreennameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :aim_screenname, :string
  end

  def self.down
    remove_column :users, :aim_screenname
  end
end
