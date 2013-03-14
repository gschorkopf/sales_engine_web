require 'spec_helper'

describe "/merchants/" do
  include Rack::Test::Methods
  include_context "standard test dataset"

  def app
    SalesEngineWeb::Server
  end

  def get_json(url)
    get url
    JSON.parse(last_response.body)
  end

  describe "random" do
    it "returns a random merchant" do
      output = get_json '/merchants/random'
      expect( [ merchant1.id, merchant2.id ] ).to include( output['id'] )
    end
  end

  describe "find" do
    context "given an existing id" do
      it "finds the merchant" do
        output = get_json "/merchants/find?id=#{ merchant1.id }"
        expect( output['id'] ).to eq merchant1.id
        expect( output['name'] ).to eq merchant1.name
      end

      it "finds merchant2" do
        output = get_json "/merchants/find?id=#{merchant2.id}"
        expect( output['id'] ).to eq merchant2.id
        expect( output['name'] ).to eq merchant2.name
      end
    end

    context "given name='gSchool'" do
      it "finds the merchant" do
        # get "/merchants/find?name=gSchool"
        # output = JSON.parse(last_response.body)
        # expect( output['id'] ).to eq merchant2.id
        # expect( output['name'] ).to eq merchant2.name
      end
    end
  end

  describe "find_all" do
    it "finds the merchants by name" do      
      output = get_json "/merchants/find_all?name=jumpstart%20lab"
      expect( output.count ).to eq 1
    end

    it "finds the merchants given part of a name" do
      get "/merchants/find_all?name=s"
      output = JSON.parse(last_response.body)
      expect( output.count ).to eq 2
    end
  end

  describe ":id/items" do
    it "returns collection of items associated with merchant" do
      output = get_json "/merchants/#{ merchant1.id }/items"
      expect( output.count ).to eq 3
    end
  end

  describe ":id/invoices" do
    it "returns collection of invoice associated with merchant from known orders" do
      output = get_json "/merchants/#{ merchant1.id }/invoices"
      expect( output.count ).to eq 0
    end
  end

  context "for multiple merchants" do
    describe "most_revenue?quantity=x" do
      it "returns the top x merchants ranked by total revenue"
    end

    describe "most_items?quantity=x" do
      it "returns the top x merchants ranked by total number of items sold"
    end

    describe "revenue?date=x" do
      it "returns the total revenue for date x across all merchants"
    end
  end

  context "for a single merchant" do
    describe ":id/revenue" do
      it "returns the total revenue for that merchant across all transactions" do
        get "/merchants/#{merchant2.id}/revenue"
        expect(last_response.body).to eq '1700'
      end
    end

    describe ":id/revenue?date=x" do
      it "returns the total revenue for that merchant for a specific invoice date"
    end

    describe ":id/favorite_customer" do
      it "returns the customer who has conducted the most successful transactions" do
        output = get_json "/merchants/#{merchant2.id}/favorite_customer"
        expect(output['first_name']).to eq 'Geoff'
      end
    end

    describe ":id/customers_with_pending_invoices" do
      it "returns a collection of customers which have pending (unpaid) invoices" do
        output = get_json "/merchants/#{merchant2.id}/customers_with_pending_invoices"
        expect(output.first["first_name"]).to eq "Tim"
      end
    end
  end
end