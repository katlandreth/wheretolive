class CountryAlias < ActiveRecord::Base

  def self.country_display_name(raw_country_name)
    find_by(name: raw_country_name).display_name
  end

end
