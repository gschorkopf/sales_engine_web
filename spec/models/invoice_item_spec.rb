require 'spec_helper'

module SalesEngineWeb
  describe InvoiceItem do
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

    describe ".find" do
      context "parameter is invoice item id" do
        it "returns matching invoice item" do
          found = InvoiceItem.find( ii1.id )
          expect(found.id).to eq ii1.id
        end
      end
    end

    describe ".find_by_item_id" do
      it "returns first matching invoice item" do
        found = InvoiceItem.find_by_item_id( ii1.item_id )
        expect(found.item_id).to eq ii1.item_id
      end
    end

    describe ".find_by_invoice_id" do
      it "returns first matching invoice item" do
        found = InvoiceItem.find_by_invoice_id( ii1.invoice_id )
        expect(found.invoice_id).to eq ii1.invoice_id
      end
    end

    describe ".find_by_quantity" do
      it "returns first matching invoice item" do
        found = InvoiceItem.find_by_quantity( ii1.quantity )
        expect(found.quantity).to eq ii1.quantity
      end
    end

    describe ".find_by_unit_price" do
      it "returns first matching invoice item" do
        found = InvoiceItem.find_by_unit_price( ii1.unit_price )
        expect(found.unit_price).to eq ii1.unit_price
      end
    end

    describe ".find_all_by_item_id" do
      it "returns all matching invoice items" do
        found = InvoiceItem.find_all_by_item_id( ii1.item_id )
        expect(found.count).to eq 2
      end
    end

    describe ".find_all_by_invoice_id" do
      it "returns all matching invoice items" do
        found = InvoiceItem.find_all_by_invoice_id( ii1.invoice_id )
        expect(found.count).to eq 2
      end
    end

    describe ".find_all_by_quantity" do
      it "returns all matching invoice items" do
        found = InvoiceItem.find_all_by_quantity( ii1.quantity )
        expect(found.count).to eq 1
      end
    end

    describe ".find_all_by_unit_price" do
      it "returns all matching invoice items" do
        found = InvoiceItem.find_all_by_unit_price( ii1.unit_price )
        expect(found.count).to eq 1
      end
    end

    describe "#invoice" do
      it "returns invoice associated with invoice item" do
        expect(ii1.invoice.merchant_id).to eq 2
      end
    end

    describe "#item" do
      it "returns item assoc with inv item" do
        expect(ii1.item.name).to eq 'Top'
      end
    end

    describe "revenue" do
      it "returns revenue for specific item" do
        expect(ii1.revenue).to eq 900
        expect(ii2.revenue).to eq 800
      end
    end
  end
end