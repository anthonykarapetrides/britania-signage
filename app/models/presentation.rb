class Presentation < ActiveRecord::Base

  has_many :placeholders, :dependent => :destroy

end
