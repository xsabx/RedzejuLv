class CreateBikes < ActiveRecord::Migration[7.1]
  def change
    create_table :bikes do |t|
      t.string :name
      t.string :type
      t.string :frame_size

      t.timestamps
    end
  end
end
