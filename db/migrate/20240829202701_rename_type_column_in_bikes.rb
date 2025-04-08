class RenameTypeColumnInBikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :bikes, :type, :bike_type
  end
end

