class RemoveAvailableFromBikes < ActiveRecord::Migration[7.1]
  def change
    remove_column :bikes, :available, :boolean
  end
end
