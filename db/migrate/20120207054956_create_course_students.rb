class CreateCourseStudents < ActiveRecord::Migration
  def self.up
    create_table :course_students do |t|
      t.integer :student_id
      t.integer :course_id

      t.timestamps
    end

 # add_index course_students [:student_id, :course_id], :unique => true
    
  end

  def self.down
    drop_table :course_students
  end
end
