require 'spec_helper'

describe "/merchants/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  before(:each) do
    merchant1 && merchant2
  end

  let(:merchant1){ SalesEngineWeb::Merchant.create(:name => "Jumpstart Lab") }
  let(:merchant2){ SalesEngineWeb::Merchant.create(:name => "gSchool") }
  let!(:item){SalesEngineWeb::Item.create(:name => "Knowledge", :merchant_id => 1)}
  let!(:invoice){SalesEngineWeb::Invoice.create(:merchant_id => 1, :status => "shipped")}
  
  describe "random" do
    it "returns a random merchant" do
      get '/merchants/random'
      output = JSON.parse(last_response.body)
      expect( [ merchant1.id, merchant2.id ] ).to include( output['id'] )
    end
  end

  describe "find" do
    context "given an existing id" do
      it "finds the merchant" do
        get "/merchants/find?id=#{ merchant1.id }"
        output = JSON.parse(last_response.body)
        expect( output['id'] ).to eq merchant1.id
        expect( output['name'] ).to eq merchant1.name
      end

      it "finds merchant2" do
        get "/merchants/find?id=#{merchant2.id}"
        output = JSON.parse(last_response.body)
        expect( output['id'] ).to eq merchant2.id
        expect( output['name'] ).to eq merchant2.name
      end
    end

    context "given name='Jumpstart%20Lab'" do
      it "finds the merchant" do
        get "/merchants/find?name=Jumpstart%20Lab"
        output = JSON.parse(last_response.body)
        expect( output['id'] ).to eq merchant1.id
        expect( output['name'] ).to eq merchant1.name
      end
    end
  end

  def get_json(url)
    get url
    JSON.parse(last_response.body)
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
      expect( output.count ).to eq 1
    end
  end

  describe ":id/invoices" do
    it "returns collection of invoice associated with merchant from known orders" do
      output = get_json "/merchants/#{ merchant1.id }/invoices"
      expect( output.count ).to eq 1
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
      it "returns the total revenue for that merchant across all transactions"
    end

    describe ":id/revenue?date=x" do
      it "returns the total revenue for that merchant for a specific invoice date"
    end

    describe ":id/favorite_customer" do
      it "returns the customer who has conducted the most successful transactions"
    end

    describe ":id/customers_with_pending_invoices" do
      it "returns a collection of customers which have pending (unpaid) invoices"
    end
  end
end