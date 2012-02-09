class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_students, :dependent => :destroy
  has_many :students, :through => :course_students
end
