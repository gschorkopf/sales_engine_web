require 'spec_helper'

module SalesEngineWeb
  describe Customer do

    let!(:customer1){ SalesEngineWeb::Customer.create(:first_name => "Geoff", :last_name => "Schorkopf") }
    let!(:customer2){ SalesEngineWeb::Customer.create(:first_name => "Tim", :last_name => "Schorkopf") }

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

  end
end