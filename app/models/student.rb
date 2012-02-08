class Student < ActiveRecord::Base
  # attr_accessible :name, :age, :address
  has_many :course_students, :dependent => :destroy
  has_many :courses, :through => :course_students
end
