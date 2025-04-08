class CreateSeenPerformances < ActiveRecord::Migration[7.1]
  def change
    create_table :seen_performances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :performance, null: false, foreign_key: true
      t.datetime :seen_at  

      t.timestamps
    end
  end
end
