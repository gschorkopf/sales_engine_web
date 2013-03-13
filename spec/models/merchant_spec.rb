require 'spec_helper'

module SalesEngineWeb
  describe Merchant do
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
      it 'creates a merchant' do
        expect( merchant1.name ).to eq "Jumpstart Lab"
      end
    end

    describe '.find_all_by_name' do
      it "returns all matching merchants" do
        merchants = Merchant.find_all_by_name("Jumpstart")
        expect( merchants.count ).to eq 1
      end
    end

    describe '.find' do
      it "finds a merchant" do
        target = Merchant.create(:name => "Jumpstart Lab")
        found  = Merchant.find( target.id )
        expect( found.id ).to eq target.id
        expect( found.name ).to eq target.name
      end
    end

    describe '.find_by_name' do
      it "finds a merchant by name" do
        found  = Merchant.find_by_name(merchant1.name)
        expect( found.id ).to eq merchant1.id
      end

      it "finds by name, case insensitive" do
        found  = Merchant.find_by_name("jumpstart lab")
        expect( found.id ).to eq merchant1.id
      end
    end

    describe ".random" do
      it "returns a merchant" do
        Merchant.create(:name => "Jumpstart Lab")
        expect( Merchant.random ).to be_kind_of(Merchant)
      end
    end

    it "implements to_hash" do
      m = Merchant.create(:name => "Jumpstart Lab")
      expect( m.to_hash[:name] ).to eq "Jumpstart Lab"
    end

    describe "#invoices" do
      it "returns invoices for merchant" do
        inv = Merchant.find(merchant1.id).invoices
        expect(inv.count).to eq 0
      end
    end

    describe "#items" do
      it "returns items for merchant" do
        items = Merchant.find(merchant1.id).items
        expect(items.count).to eq 3
      end
    end

  end
end