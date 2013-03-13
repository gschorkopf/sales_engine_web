require 'spec_helper'

describe "/customers/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  def get_json(url)
    get url
    JSON.parse(last_response.body)
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
  
  describe "find" do
    it "returns customer by id" do
      get "/customers/find?id=#{customer1.id}"
      result = JSON.parse(last_response.body)
      expect( result['id'] ).to eq customer1.id
      expect( result['first_name'] ).to eq customer1.first_name
    end

    it "returns customer by first name" do
      get "/customers/find?first_name=#{customer1.first_name}"
      result = JSON.parse(last_response.body)
      expect( result['first_name'] ).to eq customer1.first_name
    end

    it "returns customer by last name" do 
      get "/customers/find?last_name=#{customer1.last_name}"
      result = JSON.parse(last_response.body)
      expect( result['last_name'] ).to eq customer1.last_name
    end
  end

  describe "find_all" do
    it "returns customers by first name" do
      get "/customers/find_all?first_name=#{customer1.first_name}"
      output = JSON.parse(last_response.body)
      expect( output.count ).to eq 1
    end

    it "returns customers by last name" do 
      get "/customers/find_all?last_name=#{customer1.last_name}"
      results = JSON.parse(last_response.body)
      expect( results.count ).to eq 2
    end
  end

  describe "random" do
    it "returns random customer" do
      get '/customers/random'
      output = JSON.parse(last_response.body)
      expect( [ customer1.id, customer2.id ] ).to include( output['id'] )
    end
  end

  describe ":id/invoices" do
    it "returns a collection of associated invoices" do
      output = get_json "/customers/#{customer1.id}/invoices"
      expect(output.count).to eq 2
    end
  end
  
  describe ":id/transactions" do
    it "returns a collection of associated transactions" do
      output = get_json "/customers/#{customer1.id}/transactions"
      expect(output.count).to eq 3
    end
  end

  describe ":id/favorite_merchant" do
    it "returns a merchant where the customer has conducted the most successful transactions"
  end

end