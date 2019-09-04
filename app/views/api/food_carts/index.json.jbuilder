json.carts do
  json.array! @carts do |cart|
    json.id cart.id
    json.name cart.applicant
    json.food_items cart.food_items
    json.address cart.address
    json.longitude cart.lonlat.x
    json.latitude cart.lonlat.y
  end
end
