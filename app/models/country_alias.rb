class CountryAlias < ActiveRecord::Base
  belongs_to :country_display_name
  belongs_to :country
end
