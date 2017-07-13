class Click < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :usuario
end
