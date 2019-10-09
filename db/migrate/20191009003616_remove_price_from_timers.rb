class RemovePriceFromTimers < ActiveRecord::Migration[5.2]
  def change
    remove_column :timers, :price, :text
  end
end
