class CreateReadingRank < ActiveRecord::Migration
  def change
    create_table :reading_ranks do |t|
      t.string :country_name
      t.float :score
    end
  end
end
