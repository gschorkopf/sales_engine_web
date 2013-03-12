require 'spec_helper'

module SalesEngineWeb
  describe Invoice do
    describe '.create' do
      it 'creates an invoice' do
        invoice = Invoice.create(:customer_id => 1, :merchant_id => 2)
        expect( invoice.customer_id ).to eq 1
        expect( invoice.merchant_id ).to eq 2
      end
    end

    describe '.find' do
      it "finds an invoice by id" do
        target = Invoice.create(:customer_id => 1, :merchant_id => 2)
        found  = Invoice.find( target.id )
        expect( found.id ).to eq target.id
        expect( found.customer_id ).to eq target.customer_id
        expect( found.merchant_id ).to eq target.merchant_id
      end
    end

    describe '.find_by_customer_id' do
      it "finds all invoices by matching customer id" do
        target = Invoice.create(:customer_id => 1, :merchant_id => 2)
        found  = Invoice.find_by_customer_id( target.customer_id )
        expect( found.id ).to eq target.id
        expect( found.customer_id ).to eq target.customer_id
        expect( found.merchant_id ).to eq target.merchant_id
      end
    end

    describe '.find_by_merchant_id' do
      it "finds all invoices by matching customer id" do
        target = Invoice.create(:customer_id => 1, :merchant_id => 2)
        found  = Invoice.find_by_merchant_id( target.merchant_id )
        expect( found.id ).to eq target.id
        expect( found.customer_id ).to eq target.customer_id
        expect( found.merchant_id ).to eq target.merchant_id
      end
    end

    describe ".random" do
      it "returns an invoice" do
        Invoice.create(:customer_id => 1, :merchant_id => 2)
        expect( Invoice.random ).to be_kind_of(Invoice)
      end
    end

    describe ".find_all_by_merchant_id" do
        it "finds all matching invoices"
    end

    describe ".find_all_by_customer_id" do
        it "finds all matching invoices"
    end

    describe ".find_all_by_status" do
        it "finds all matching invoices"
    end


  end
end