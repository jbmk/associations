class AddDetailsToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :user_id, :integer
  end

  def self.down
    remove_column :students, :user_id
  end
end
