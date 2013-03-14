require 'spec_helper'

module SalesEngineWeb
  describe InvoiceItem do
    include_context "standard test dataset"

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