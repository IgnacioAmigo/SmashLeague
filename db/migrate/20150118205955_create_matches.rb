class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :challenger_id
      t.integer :challenged_id
      t.boolean :challenger_won
      t.string :description
      t.string :proof

      t.timestamps
    end
  end
end
