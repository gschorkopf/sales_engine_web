require 'spec_helper'

module SalesEngineWeb
  describe Transaction do

    describe ".find" do
      context "parameter is transaction id" do
        it "returns transaction"
      end
    end

    describe ".find_by_invoice_id" do
      it "returns first matching transaction"
    end

    describe ".find_by_cc" do
      it "returns first matching transaction"
    end

    describe ".find_by_cc_exp" do
      it "returns first matching transaction"
    end

    describe ".find_by_all_by_invoice_id" do
      it "returns all matching transactions"
    end

    describe ".find_by_all_by_cc" do
      it "returns all matching transactions"
    end

    describe ".find_by_all_by_cc_exp" do
      it "returns all matching transactions"
    end

    describe ".find_by_all_by_result" do
      it "returns all matching transactions"
    end

  end
end