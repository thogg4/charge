class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.bigint :amount

      t.timestamps
    end
  end
end
