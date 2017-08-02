class CreateMathRank < ActiveRecord::Migration
  def change
    create_table :math_ranks do |t|
      t.string :country_name
      t.float :score
    end
  end
end
