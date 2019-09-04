class CreateFoodCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :food_carts do |t|
      t.string :address
      t.string :facility
      t.st_point :lonlat, geographic: true, null: false
      t.string :applicant, null: false
      t.string :status
      t.date :expiration
      t.string :food_items, array: true, default: []

      t.timestamps
    end
  end
end
