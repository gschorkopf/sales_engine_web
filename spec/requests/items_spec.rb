require 'spec_helper'

describe "/items/" do
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
    it "returns the top x items ranked by total revenue generated"
  end

  describe "most_items?quantity=x" do
    it "returns the top x item instances ranked by total number sold"
  end

  describe ":id/best_day" do
    it "returns the date with the most sales for the given item using the invoice date"
  end

end