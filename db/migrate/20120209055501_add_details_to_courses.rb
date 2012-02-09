class AddDetailsToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :user_id, :integer
  end

  def self.down
    remove_column :courses, :user_id
  end
end
