require 'spec_helper'

describe "/merchants/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  let!(:customer1){ SalesEngineWeb::Customer.create(:first_name => "Geoff", :last_name => "Schorkopf") }
  let!(:customer2){ SalesEngineWeb::Customer.create(:first_name => "Tim", :last_name => "Schorkopf") }
  let!(:ii1){ SalesEngineWeb::InvoiceItem.create(item_id: 1, invoice_id: 1, quantity: 9, unit_price: 100) }
  let!(:ii2){ SalesEngineWeb::InvoiceItem.create(item_id: 2, invoice_id: 1, quantity: 4, unit_price: 200) }
  let!(:ii3){ SalesEngineWeb::InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 5, unit_price: 200) }
  let!(:invoice1){ SalesEngineWeb::Invoice.create(:customer_id => 1, :merchant_id => 2, :status => "shipped") }
  let!(:invoice2){ SalesEngineWeb::Invoice.create(:customer_id => 1, :merchant_id => 3, :status => "shipped") }
  let!(:invoice3){ SalesEngineWeb::Invoice.create(:customer_id => 2, :merchant_id => 2, :status => "shipped") }
  let!(:item1){ SalesEngineWeb::Item.create(name: 'Top', description: 'Spinning toy',
                unit_price: 7200, merchant_id: 1) }
  let!(:item2){ SalesEngineWeb::Item.create(name: 'Game Boy', description: 'Handheld toy',
                unit_price: 7200, merchant_id: 1) }
  let!(:item3){ SalesEngineWeb::Item.create(name: 'Cell phone', description: 'Communication device',
                unit_price: 35000, merchant_id: 1) }
  let!(:merchant1){ SalesEngineWeb::Merchant.create(name: "Jumpstart Lab")}
  let!(:merchant2){ SalesEngineWeb::Merchant.create(name: "gSchool")}
  let!(:trans1){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'failed', credit_card_number: 4567) }
  let!(:trans2){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'success', credit_card_number: 4567) }
  let!(:trans3){SalesEngineWeb::Transaction.create(invoice_id: 2, result: 'success', credit_card_number: 1234) }
  let!(:trans4){SalesEngineWeb::Transaction.create(invoice_id: 3, result: 'failed', credit_card_number: 9999) }
  
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

    context "given name='gSchool'" do
      it "finds the merchant" do
        # get "/merchants/find?name=gSchool"
        # output = JSON.parse(last_response.body)
        # expect( output['id'] ).to eq merchant2.id
        # expect( output['name'] ).to eq merchant2.name
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