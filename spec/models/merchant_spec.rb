require 'spec_helper'

module SalesEngineWeb
  describe Merchant do
    include_context "standard test dataset"

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

    describe "#revenue" do
      it "returns total revenue for that merchant across all invoices" do
        expect(merchant1.revenue).to eq 0
        expect(merchant2.revenue).to eq 1700
      end
    end
  end
end