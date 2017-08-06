class Usuario < ActiveRecord::Base
  belongs_to :campus, class_name: "Campus", foreign_key: "campus_id"
end
