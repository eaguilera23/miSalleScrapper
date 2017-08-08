class Feedback < ActiveRecord::Base
  self.table_name = "feedback"

  belongs_to :usuario

end
