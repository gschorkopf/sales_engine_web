require 'spec_helper'

module SalesEngineWeb
  describe InvoiceItem do

    describe ".find" do
      context "parameter is invoice item id" do
        it "returns matching invoice item"
      end
    end

    describe ".find_by_item_id" do
      it "returns first matching invoice item"
    end

    describe ".find_by_invoice_id" do
      it "returns first matching invoice item"
    end

    describe ".find_by_quantity" do
      it "returns first matching invoice item"
    end

    describe ".find_by_unit_price" do
      it "returns first matching invoice item"
    end

    describe ".find_all_by_item_id" do
      it "returns all matching invoice items"
    end

    describe ".find_all_by_invoice_id" do
      it "returns all matching invoice items"
    end

    describe ".find_all_by_quantity" do
      it "returns all matching invoice items"
    end

    describe ".find_all_by_unit_price" do
      it "returns all matching invoice items"
    end

  end
end