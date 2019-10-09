class CreateTimers < ActiveRecord::Migration[5.2]
  def change
    create_table :timers do |t|
      t.text :price
      t.date :date
      t.datetime :deadline

      t.timestamps
    end
  end
end
