class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.text :content
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
