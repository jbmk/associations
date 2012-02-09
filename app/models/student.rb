class Student < ActiveRecord::Base
  belongs_to :user
  has_many :course_students, :dependent => :destroy
  has_many :courses, :through => :course_students
end
