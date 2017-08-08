class Usuario < ActiveRecord::Base
  belongs_to :campus, class_name: "Campus", foreign_key: "campus_id"
  has_many :feedback, class_name: "Feedback"
end
