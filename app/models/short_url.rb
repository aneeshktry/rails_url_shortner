class ShortUrl < ActiveRecord::Base

#  attr_accessible :original_url,:random_string,:shortend_url

  validates :original_url, :presence=> true
end
