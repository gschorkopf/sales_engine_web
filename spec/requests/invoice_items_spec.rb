require 'spec_helper'

describe "/invoice_items/" do
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
      it "returns invoice item by id" do
        output = get_json "/invoice_items/find?id=#{ ii1.id }"
        expect( output['id'] ).to eq ii1.id
      end

      it "returns invoice item by item id" do
        output = get_json "/invoice_items/find?item_id=#{ ii1.item_id }"
        expect( output['item_id'] ).to eq ii1.item_id
      end

      it "returns invoice item by invoice id" do
        output = get_json "/invoice_items/find?invoice_id=#{ ii1.invoice_id }"
        expect( output['invoice_id'] ).to eq ii1.invoice_id
      end

      it "returns invoice item by quantity" do
        output = get_json "/invoice_items/find?quantity=#{ ii1.quantity }"
        expect( output['quantity'] ).to eq ii1.quantity
      end

      it "returns invoice item by unit price" do
        output = get_json "/invoice_items/find?unit_price=#{ ii1.unit_price }"
        expect( output['unit_price'] ).to eq ii1.unit_price
      end
    end

    describe "find_all" do
      it "returns invoice items by item id" do
        output = get_json "/invoice_items/find_all?item_id=#{ ii1.item_id }"
        expect( output.count ).to eq 2
      end

      it "returns invoice items by invoice id" do
        output = get_json "/invoice_items/find_all?invoice_id=#{ ii1.invoice_id }"
        expect( output.count ).to eq 2
      end

      it "returns invoice items by quantity" do
        output = get_json "/invoice_items/find_all?quantity=#{ ii1.quantity }"
        expect( output.count ).to eq 1
      end

      it "returns invoice items by unit price" do
        output = get_json "/invoice_items/find_all?unit_price=#{ ii1.unit_price }"
        expect( output.count ).to eq 1
      end
    end

    describe "random" do
      it "returns random invoice item" do
        output = get_json "/invoice_items/random"
        expect( [ ii1.id, ii2.id, ii3.id ] ).to include( output['id'] )
      end
    end

    describe ":id/invoice" do
      it "returns the associated invoice" do
        output = get_json "/invoice_items/#{ii1.id}/invoice"
        expect(output['merchant_id']).to eq 2
        expect(output['customer_id']).to eq 1
      end
    end

    describe ":id/item" do
      it "returns the associated item" do
        output = get_json "/invoice_items/#{ii1.id}/item"
        expect(output['name']).to eq 'Top'
        expect(output['description']).to eq 'Spinning toy'
      end
    end

end