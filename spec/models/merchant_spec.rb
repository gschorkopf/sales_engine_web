require 'spec_helper'

module SalesEngineWeb
  describe Merchant do
    let!(:item){SalesEngineWeb::Item.create(:name => "Knowledge", :merchant_id => 1)}
    let!(:invoice){SalesEngineWeb::Invoice.create(:merchant_id => 1, :status => "shipped")}
  
    describe '.create' do
      it 'creates a merchant' do
        merchant = Merchant.create(:name => "Jumpstart Lab")
        expect( merchant.name ).to eq "Jumpstart Lab"
      end
    end

    describe '.find_all_by_name' do
      it "returns all matching merchants" do
        Merchant.create(:name => "Jumpstart Lab")
        Merchant.create(:name => "Jumpstart Party")
        merchants = Merchant.find_all_by_name("Jumpstart")
        expect( merchants.count ).to eq 2
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
        target = Merchant.create(:name => "Jumpstart Lab")
        found  = Merchant.find_by_name("Jumpstart Lab")
        expect( found.id ).to eq target.id
        expect( found.name ).to eq target.name
      end

      it "finds by name, case insensitive" do
        target = Merchant.create(:name => "Jumpstart Lab")
        found  = Merchant.find_by_name("jumpstart lab")
        expect( found.id ).to eq target.id
        expect( found.name ).to eq target.name
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
        target = Merchant.create(:name => "Jumpstart Lab")
        inv = Merchant.find(target.id).invoices
        expect(inv.count).to eq 1
      end
    end

    describe "#items" do
      it "returns items for merchant" do
        target = Merchant.create(:name => "Jumpstart Lab")
        items = Merchant.find(target.id).items
        expect(items.count).to eq 1
      end
    end

  end
end