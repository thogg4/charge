class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :product_id
      t.integer :times_run, default: 0

      t.timestamps
    end
  end
end
