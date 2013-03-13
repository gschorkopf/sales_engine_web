require 'spec_helper'

module SalesEngineWeb
  describe Item do
    let!(:item1){ SalesEngineWeb::Item.create(name: 'Top', description: 'Spinning toy',
                  unit_price: 7200, merchant_id: 1) }
    let!(:item2){ SalesEngineWeb::Item.create(name: 'Game Boy', description: 'Handheld toy',
                  unit_price: 7200, merchant_id: 1) }
    let!(:item3){ SalesEngineWeb::Item.create(name: 'Cell phone', description: 'Communication device',
                  unit_price: 35000, merchant_id: 1) }

    describe ".find" do
      it "returns matching item" do
        found = Item.find( item1.id )
        expect(found.id).to eq item1.id
      end
    end

    describe ".find_by_name" do
      it "returns first matching item" do
        found = Item.find_by_name( item1.name )
        expect(found.name).to eq item1.name
      end
    end

    describe ".find_by_description" do
      it "returns first matching item" do
        found = Item.find_by_description( item1.description )
        expect(found.description).to eq item1.description
      end
    end

    describe ".find_by_unit_price" do
      it "returns first matching item" do
        found = Item.find_by_unit_price( item1.unit_price )
        expect(found.unit_price).to eq item1.unit_price
      end
    end

    describe ".find_by_merchant_id" do
      it "returns first matching item" do
        found = Item.find_by_merchant_id( item1.merchant_id )
        expect(found.merchant_id).to eq item1.merchant_id
      end
    end

    describe ".find_all_by_name" do
      it "returns all matching items" do
        found = Item.find_all_by_name( item1.name )
        expect(found.count).to eq 1
      end
    end

    describe ".find_all_by_description" do
      it "returns all matching items" do
        found = Item.find_all_by_description('toy')
        expect(found.count).to eq 2
      end
    end

    describe ".find_all_by_unit_price" do
      it "returns all matching items" do
        found = Item.find_all_by_unit_price( 7200 )
        expect(found.count).to eq 2
      end
    end

    describe ".find_all_by_merchant_id" do
      it "returns all matching items" do
        found = Item.find_all_by_merchant_id( 1 )
        expect(found.count).to eq 3
      end
    end


  end
end