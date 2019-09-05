require 'rails_helper'

RSpec.describe FoodCart, type: :model do

  let :valid_json do
    {
      "objectid" => "1351263",
      "applicant" => "Isidoro Serrano",
      "facilitytype" => "Push Cart",
      "cnn" => "1108000",
      "locationdescription" => "21ST ST: CAPP ST to MISSION ST (3150 - 3199)",
      "address" => "2501 MISSION ST",
      "blocklot" => "3615070",
      "block" => "3615",
      "lot" => "070",
      "permit" => "19MFF-00075",
      "status" => "REQUESTED",
      "x" => "6007059.55277",
      "y" => "2103743.32313",
      "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=19MFF-00075&ExportPDF=1&Filename=19MFF-00075_schedule.pdf",
      "received" => "2019-07-12",
      "priorpermit" => "0",
      "expirationdate" => "2020-07-15T00:00:00.000",
      "location" => {
        "latitude" => "37.7568774515357",
        "longitude" => "-122.418579889476"
      }
    }
  end

  let :invalid_json do
    {
    # "objectid" => "1351263",
    # "applicant" => "Isidoro Serrano",
    "facilitytype" => "Push Cart",
    "cnn" => "1108000",
    "locationdescription" => "21ST ST: CAPP ST to MISSION ST (3150 - 3199)",
    "address" => "2501 MISSION ST",
    "blocklot" => "3615070",
    "block" => "3615",
    "lot" => "070",
    "permit" => "19MFF-00075",
    "status" => "REQUESTED",
    "x" => "6007059.55277",
    "y" => "2103743.32313",
    "latitude" => "37.7568774515357",
    "longitude" => "-122.418579889476",
    "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=19MFF-00075&ExportPDF=1&Filename=19MFF-00075_schedule.pdf",
    "received" => "2019-07-12",
    "priorpermit" => "0",
    "expirationdate" => "2020-07-15T00:00:00.000"
    }
  end

  it "should create a record with valid json" do
    expect(FoodCart.count).to eq 0

    expect(FoodCart.load_from_json(valid_json)).to be true

    expect(FoodCart.count).to eq 1
    expect(FoodCart.first.id).to eq valid_json["objectid"].to_i
    expect(FoodCart.first.applicant).to eq valid_json["applicant"]
  end

  it "should replace a record with the same id" do
    expect(FoodCart.count).to eq 0
    expect(FoodCart.load_from_json(valid_json)).to be true
    expect(FoodCart.count).to eq 1

    valid_json["applicant"] = "Kramerica"
    expect(FoodCart.load_from_json(valid_json)).to be true
    expect(FoodCart.count).to eq 1

    expect(FoodCart.first.id).to eq valid_json["objectid"].to_i
    expect(FoodCart.first.applicant).to eq valid_json["applicant"]
  end

  it "should handle invalid json gracefully" do
    expect(FoodCart.count).to eq 0
    expect(FoodCart.load_from_json(invalid_json)).to be false
    expect(FoodCart.count).to eq 0
  end

  it "should filter based on location" do
    FoodCart.load_from_json(valid_json)
    expect(FoodCart.count).to eq 1

    found = FoodCart.around_location("-122.418579889475", "37.7568774515356").count
    expect(found).to eq 1

    found = FoodCart.around_location("122.418579889475", "37.7568774515356").count
    expect(found).to eq 0
  end

end
