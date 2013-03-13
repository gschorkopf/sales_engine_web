require 'spec_helper'

module SalesEngineWeb
  describe Customer do

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
      context "parameter is an id" do
        it "returns matching customer" do
          found = Customer.find(customer1.id)
          expect( found.id ).to eq customer1.id
        end
      end
    end

    describe ".find_by_first_name" do
      it "returns first matching customer" do
        found = Customer.find_by_first_name(customer1.first_name)
        expect( found.first_name ).to eq customer1.first_name
      end
    end

    describe ".find_by_last_name" do
      it "returns first matching customers" do
        found = Customer.find_by_last_name(customer1.last_name)
        expect( found.last_name ).to eq customer1.last_name
      end
    end

    describe ".find_all_by_first_name" do
      it "finds all matching customers" do
        found = Customer.find_all_by_first_name(customer1.first_name)
        expect( found.count ).to eq 1
      end
    end

    describe ".find_all_by_last_name" do
      it "finds all matching customers" do
        found = Customer.find_all_by_last_name(customer1.last_name)
        expect( found.count ).to eq 2
      end
    end

    describe "#invoices" do
      it "returns invoices associated with customer" do
        expect(customer1.invoices.count).to eq 2
      end
    end

    describe "#transactions" do
      it "returns transactions associated with customer" do
        expect(customer1.transactions.count).to eq 3
      end
    end
  end
end