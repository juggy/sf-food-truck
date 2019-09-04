class Api::FoodCartsController < ApplicationController

  def index
    @carts = FoodCart.approved
                     .around_location(location_params[0].to_f,
                                      location_params[1].to_f,
                                      location_params[2].to_i)
  end

  protected

  def location_params

    params.require([:lng, :lat, :radius])

  end
end
