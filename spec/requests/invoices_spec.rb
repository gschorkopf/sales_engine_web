require 'spec_helper'

describe "/invoices/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  let!(:invoice1){ SalesEngineWeb::Invoice.create(:merchant_id => 1, :customer_id => 2, :status => "shipped") }
  let!(:invoice2){ SalesEngineWeb::Invoice.create(:merchant_id => 1, :customer_id => 3, :status => "shipped") }

  describe "random" do
    it "returns a random invoice" do
      get '/invoices/random'
      output = JSON.parse(last_response.body)
      expect( [ invoice1.id, invoice2.id ] ).to include( output['id'] )
    end
  end

  describe "find" do
    context "given an existing id" do
      it "finds the invoice" do
        get "/invoices/find?id=#{ invoice1.id }"
        output = JSON.parse(last_response.body)
        expect( output['id'] ).to eq invoice1.id
        expect( output['customer_id'] ).to eq invoice1.customer_id
      end
    end
  end

  describe "find_all" do
    it "finds by merchant id" do
      get "/invoices/find_all?merchant_id=#{ invoice1.merchant_id }"
      output = JSON.parse(last_response.body)
      expect( output.count ).to eq 2
    end

    it "finds by customer id" do 
      get "/invoices/find_all?customer_id=#{ invoice1.customer_id }"
      output = JSON.parse(last_response.body)
      expect( output.count ).to eq 1
    end

    it "finds by status" do
      get "/invoices/find_all?status=#{ invoice1.status }"
      output = JSON.parse(last_response.body)
      expect( output.count ).to eq 2
    end  
  end

  describe "invoices/:id/transactions" do
    it "returns a collection of associated transactions"
  end

  describe "invoices/:id/invoice_items" do
    it "returns a collection of associated invoice items"
  end

  describe "invoices/:id/items" do
    it "returns a collection of associated items"
  end

  describe "invoices/:id/customer" do
    it "returns the associated customer"
  end

  describe "invoices/:id/merchant" do
    it "returns the associated merchant"
  end

end