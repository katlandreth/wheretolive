class ChangeGeolocationToLatAndLong < ActiveRecord::Migration
  def up
    rename_column :places, :geolocation, :latitude
    add_column :places, :longitude, :float
  end

  def down
    rename_column :places, :latitude, :geolocation
    remove_column :places, :longitude
  end
end
