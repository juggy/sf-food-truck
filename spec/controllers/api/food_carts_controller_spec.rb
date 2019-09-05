require 'rails_helper'

RSpec.describe Api::FoodCartsController, type: :controller do

  describe "GET index" do

    before :each do
      @cart = FoodCart.create! applicant: "Joey's",
                               food_items: ['donuts', 'salads', 'black velvets'],
                               address: "533 Alexandre the Great",
                               lonlat: "POINT(-122.418579889476 37.7568774515357)",
                               status: "APPROVED"

    end

    it "renders the carts" do
      get :index, params: { lng: "-122.418579889476", lat: "37.7568774515357", radius: "2000", format: :json}

      expect(response.content_type).to include "application/json"
      expect(response.status).to eq(200)

      json = JSON.parse(response.body)
      expect(json["carts"].size).to eq(1)
      expect(json["carts"][0]["name"]).to eq(@cart.applicant)
    end

    it "requires params" do
      get :index, :format => :json

      expect(response.status).to eq(422)
    end
  end

end
