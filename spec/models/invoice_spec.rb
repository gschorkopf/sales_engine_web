require 'spec_helper'

module SalesEngineWeb
  describe Invoice do
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

    describe '.create' do
      it 'creates an invoice' do
        expect( invoice1.customer_id ).to eq 1
        expect( invoice1.merchant_id ).to eq 2
      end
    end

    describe '.find' do
      it "finds an invoice by id" do
        found  = Invoice.find( invoice1.id )
        expect( found.id ).to eq invoice1.id
        expect( found.customer_id ).to eq invoice1.customer_id
        expect( found.merchant_id ).to eq invoice1.merchant_id
      end
    end

    describe '.find_by_customer_id' do
      it "finds all invoices by matching customer id" do
        found  = Invoice.find_by_customer_id( invoice1.customer_id )
        expect( found.id ).to eq invoice1.id
        expect( found.customer_id ).to eq invoice1.customer_id
        expect( found.merchant_id ).to eq invoice1.merchant_id
      end
    end

    describe '.find_by_merchant_id' do
      it "finds all invoices by matching customer id" do
        found  = Invoice.find_by_merchant_id( invoice1.merchant_id )
        expect( found.id ).to eq invoice1.id
        expect( found.customer_id ).to eq invoice1.customer_id
        expect( found.merchant_id ).to eq invoice1.merchant_id
      end
    end

    describe ".random" do
      it "returns an invoice" do
        Invoice.create(:customer_id => 1, :merchant_id => 2)
        expect( Invoice.random ).to be_kind_of(Invoice)
      end
    end

    context "multiple invoices" do
      describe ".find_all_by_merchant_id" do
        it "finds all matching invoices" do
          invoices = Invoice.find_all_by_merchant_id(2)
          expect(invoices.count).to eq 1
        end
      end

      describe ".find_all_by_customer_id" do
        it "finds all matching invoices" do
          invoices = Invoice.find_all_by_customer_id(1)
          expect(invoices.count).to eq 2
        end
      end

      describe ".find_all_by_status" do
        it "finds all matching invoices, regardless of caps" do
          invoices = Invoice.find_all_by_status("shiPPed")
          expect(invoices.count).to eq 2
        end
      end
    end

    describe "#transactions" do
      it "returns trans assoc with invoice" do
        expect(invoice1.transactions.count).to eq 2
      end
    end

    describe "#invoice_items" do
      it "returns iis assoc with invoice" do
        expect(invoice1.invoice_items.count).to eq 2
      end
    end

    describe "#items" do
      it "returns items assoc with invoice" do
        expect(invoice1.items.count).to eq 2
      end
    end

    describe "#customer" do
      it "returns cust assoc with invoice" do
        expect(invoice1.customer.first_name).to eq "Geoff"
      end
    end

    describe "#merchant" do
      it "returns merch assoc with invoice" do
        expect(invoice1.merchant.name).to eq 'gSchool'
      end
    end

    describe "#revenue" do
      it "returns revenue for invoice" do
        expect(invoice1.revenue).to eq 1700
        expect(invoice2.revenue).to eq 1000
      end
    end
  end
end