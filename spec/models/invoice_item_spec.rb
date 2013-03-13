require 'spec_helper'

module SalesEngineWeb
  describe InvoiceItem do
    let!(:ii1){ SalesEngineWeb::InvoiceItem.create(item_id: 1, invoice_id: 1, quantity: 9, unit_price: 100) }
    let!(:ii2){ SalesEngineWeb::InvoiceItem.create(item_id: 2, invoice_id: 1, quantity: 4, unit_price: 200) }
    let!(:ii3){ SalesEngineWeb::InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 5, unit_price: 200) }

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

  end
end