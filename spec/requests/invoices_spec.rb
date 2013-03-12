require 'spec_helper'

describe "/invoices/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  before(:each) do
    invoice1 && invoice2
  end

  let(:invoice1){ SalesEngineWeb::Invoice.create(:merchant_id => 1, :customer_id => 2) }
  let(:invoice2){ SalesEngineWeb::Invoice.create(:merchant_id => 1, :customer_id => 3) }

  describe "random" do
    it "returns a random invoice" do
      pending
      get '/invoices/random'
      output = JSON.parse(last_response.body)
      expect( [ invoice1.id, invoice2.id ] ).to include( output['id'] )
    end
  end

  describe "find" do
    context "given an existing id" do
      it "finds the invoice" do
        pending
        get "/invoices/find?id=#{ invoice1.id }"
        output = JSON.parse(last_response.body)
        expect( output['id'] ).to eq invoice1.id
        expect( output['name'] ).to eq invoice1.name
      end
    end
  end

  describe "find_all" do
    it "finds by merchant id"
    it "finds by customer id"
    it "finds by status"
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