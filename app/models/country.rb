class Country < ActiveRecord::Base
  validates :name, presence: true

  def self.non_data_columns
    ["id", "created_at", "updated_at", "name", "country_code"]
  end

end
