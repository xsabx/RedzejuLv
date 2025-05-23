class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :performance, null: false, foreign_key: true
      t.text :content
      t.integer :rating
      t.datetime :seen_at

      t.timestamps
    end
  end
end 