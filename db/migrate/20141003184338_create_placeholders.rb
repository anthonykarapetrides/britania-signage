class CreatePlaceholders < ActiveRecord::Migration
  def change
    create_table :placeholders do |t|
      t.integer :presentation_id
      t.string :name
      t.string :category
      t.string :header
      t.text :content
      t.timestamps
    end
  end
end
