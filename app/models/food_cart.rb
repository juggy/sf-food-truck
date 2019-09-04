class FoodCart < ApplicationRecord

  def self.approved
    where(status: "APPROVED")
  end

  def self.around_location(lng, lat, distance = 2000)
    where(%{
      ST_DWithin(
        lonlat,
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [lng, lat, distance])
  end

  def self.load_from_json(cart_json)

    location = cart_json["location"]
    return false unless location.present?

    id = cart_json["objectid"]
    return false unless location.present?

    fooditems = cart_json["fooditems"]

    attrs = {
      applicant: cart_json["applicant"],
      address: cart_json["address"],
      status: cart_json["status"],
      expiration: cart_json["expirationdate"],
      lonlat: "POINT(#{location["longitude"]} #{location["latitude"]})",
      food_items: fooditems.present? ? fooditems.split(": ") : []
    }

    cart = FoodCart.where(id: id)
                   .first_or_initialize(id: id)

    cart.assign_attributes attrs

    cart.save

  end

end
