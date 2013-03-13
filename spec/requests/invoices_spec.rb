require 'spec_helper'

describe "/invoices/" do
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
  
  describe "random" do
    it "returns a random invoice" do
      output = get_json '/invoices/random'
      expect( [ invoice1.id, invoice2.id ] ).to include( output['id'] )
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
      expect( output.count ).to eq 1
    end

    it "finds by customer id" do 
      output = get_json "/invoices/find_all?customer_id=#{ invoice1.customer_id }"
      expect( output.count ).to eq 2
    end

    it "finds by status" do
      output = get_json "/invoices/find_all?status=#{ invoice1.status }"
      expect( output.count ).to eq 2
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