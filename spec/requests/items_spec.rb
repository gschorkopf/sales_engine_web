require 'spec_helper'

describe "/items/" do
  include Rack::Test::Methods
  include_context "standard test dataset"

  def app
    SalesEngineWeb::Server
  end

  def get_json(url)
    get url
    JSON.parse(last_response.body)
  end

  describe "find" do
    it "returns item by id" do
      output = get_json "/items/find?id=#{ item1.id }"
      expect( output['id'] ).to eq item1.id
    end

    it "returns item by name" do
      output = get_json "/items/find?name=#{ item1.name }"
      expect( output['name'] ).to eq item1.name
    end

    it "returns item by description" do
      output = get_json "/items/find?description=toy"
      expect( output['description'] ).to eq item1.description
    end

    it "returns item by unit price" do
      output = get_json "/items/find?unit_price=#{ item1.unit_price }"
      expect( output['unit_price'] ).to eq item1.unit_price
    end

    it "returns item by merchant id" do
      output = get_json "/items/find?merchant_id=#{ item1.merchant_id }"
      expect( output['merchant_id'] ).to eq item1.merchant_id
    end
  end

  describe "find_all" do
    it "returns items by name" do 
      output = get_json "/items/find_all?name=#{ item1.name }"
      expect( output.count ).to eq 1
    end

    it "returns items by description" do
      output = get_json "/items/find_all?description=toy"
      expect( output.count ).to eq 2
    end

    it "returns items by unit price" do
      output = get_json "/items/find_all?unit_price=#{ item1.unit_price }"
      expect( output.count ).to eq 2
    end

    it "returns items by merchant id" do
      output = get_json "/items/find_all?merchant_id=#{ item1.merchant_id }"
      expect( output.count ).to eq 3
    end
  end

  describe "random" do
    it "returns random item" do
      get '/items/random'
      output = JSON.parse(last_response.body)
      expect( [ item1.id, item2.id, item3.id ] ).to include( output['id'] )
    end
  end

  describe ":id/invoice_items" do
    it "returns a collection of associated invoice items" do
      output = get_json "/items/#{item1.id}/invoice_items"
      expect(output.count).to eq 2
    end
  end

  describe ":id/merchant" do
    it "returns the associated merchant" do
      output = get_json "/items/#{item1.id}/merchant"
      expect(output['name']).to eq "Jumpstart Lab"
    end
  end

  describe "most_revenue?quantity=x" do
    it "returns the top x items ranked by total revenue generated" do
      output = get_json "/items/most_revenue?quantity=2"
      expect(output.first['name']).to eq 'Top'
      expect(output.count).to eq 2
    end
  end

  describe "most_items?quantity=x" do
    it "returns the top x item instances ranked by total number sold" do
      output = get_json "/items/most_items?quantity=2"
      expect(output.first['name']).to eq 'Top'
      expect(output.count).to eq 2
    end

    it "returns the top x item instances ranked by total number sold again" do
      output = get_json "/items/most_items?quantity=3"
      expect(output.last['name']).to eq 'Cell phone'
      expect(output.count).to eq 3
    end
  end
end