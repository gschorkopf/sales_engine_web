require 'spec_helper'

module SalesEngineWeb
  describe Customer do
    include_context "standard test dataset"

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

    describe ".all" do
      it "returns all customers" do
        customers = Customer.all
        expect(customers.count).to eq 2
        expect(customers[0].first_name).to eq "Geoff"
      end
    end
  end
end