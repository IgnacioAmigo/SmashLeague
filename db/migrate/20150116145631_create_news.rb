class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :body
      t.integer :user_id
      t.boolean :show

      t.timestamps
    end
  end
end
