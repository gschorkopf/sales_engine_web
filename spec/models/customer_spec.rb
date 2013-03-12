require 'spec_helper'

module SalesEngineWeb
  describe Customer do

    describe ".find" do
      context "parameter is an id" do
        it "returns matching customer"
      end
    end

    describe ".find_by_first_name" do
      it "returns first matching customer"
    end

    describe ".find_by_last_name" do
      it "returns first matching customers"
    end

    describe ".find_all_by_first_name" do
        it "finds all matching customers"
    end

    describe ".find_all_last_name" do
        it "finds all matching customers"
    end

  end
end