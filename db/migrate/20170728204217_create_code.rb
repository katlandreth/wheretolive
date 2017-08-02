class CreateCode < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :country_name
      t.string :value
    end
  end
end
