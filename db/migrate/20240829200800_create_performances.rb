class CreatePerformances < ActiveRecord::Migration[7.1]
  def change
    create_table :performances do |t|
      t.string :title               
      t.string :theater             
      t.text :description           
      t.datetime :performed_at      

      t.timestamps
    end
  end
end

