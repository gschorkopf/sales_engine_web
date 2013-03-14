require 'spec_helper'

describe "/invoices/" do
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
    it "returns a random invoice" do
      output = get_json '/invoices/random'
      expect( [ invoice1.id, invoice2.id, invoice3.id ] ).to include( output['id'] )
    end
  end

  describe "find" do
    context "given an existing id" do
      it "finds the invoice" do
        output = get_json "/invoices/find?id=#{ invoice1.id }"
        expect( output['id'] ).to eq invoice1.id
        expect( output['customer_id'] ).to eq invoice1.customer_id
      end
    end
  end

  describe "find_all" do
    it "finds by merchant id" do
      output = get_json "/invoices/find_all?merchant_id=#{ invoice1.merchant_id }"
      expect( output.count ).to eq 2
    end

    it "finds by customer id" do 
      output = get_json "/invoices/find_all?customer_id=#{ invoice1.customer_id }"
      expect( output.count ).to eq 2
    end

    it "finds by status" do
      output = get_json "/invoices/find_all?status=#{ invoice1.status }"
      expect( output.count ).to eq 3
    end  
  end

  describe ":id/transactions" do
    it "returns a collection of associated transactions" do
      output = get_json "/invoices/#{invoice1.id}/transactions"
      expect(output.count).to eq 2
    end
  end

  describe ":id/invoice_items" do
    it "returns a collection of associated invoice items" do
      output = get_json "/invoices/#{invoice1.id}/invoice_items"
      expect(output.count).to eq 2
    end
  end

  describe ":id/items" do
    it "returns a collection of associated items" do
      output = get_json "/invoices/#{invoice1.id}/items"
      expect(output.count).to eq 2
    end
  end

  describe ":id/customer" do
    it "returns the associated customer" do
      output = get_json "/invoices/#{invoice1.id}/customer"
      expect(output['first_name']).to eq "Geoff"
    end
  end

  describe ":id/merchant" do
    it "returns the associated merchant" do
      output = get_json "/invoices/#{invoice1.id}/merchant"
      expect(output['name']).to eq "gSchool"
    end
  end

end