class Course < ActiveRecord::Base
  # attr_accessible :name, :code
  has_many :course_students, :dependent => :destroy
  has_many :students, :through => :course_students
end
