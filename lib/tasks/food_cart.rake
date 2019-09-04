require 'net/http'
require 'json'

namespace :food_cart do
  desc "Loads food carts from the source"
  task :load => :environment do

    url = ENV["SOURCE_URL"]
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response).each do |cart_json|

      FoodCart.load_from_json(cart_json)

    end

  end
end
