require 'spec_helper'

module SalesEngineWeb
  describe Transaction do
    let!(:trans1){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'failed', credit_card_number: 4567) }
    let!(:trans2){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'success', credit_card_number: 4567) }
    let!(:trans3){SalesEngineWeb::Transaction.create(invoice_id: 2, result: 'success', credit_card_number: 1234) }


    describe ".find" do
      context "parameter is transaction id" do
        it "returns transaction" do
          found = Transaction.find( trans1.id )
          expect(found.id).to eq trans1.id
        end
      end
    end

    describe ".find_by_invoice_id" do
      it "returns first matching transaction" do
        found = Transaction.find_by_invoice_id( trans1.invoice_id )
        expect(found.invoice_id).to eq trans1.invoice_id
      end
    end

    describe ".find_by_cc" do
      it "returns first matching transaction" do
        found = Transaction.find_by_credit_card_number( trans1.credit_card_number )
        expect(found.credit_card_number).to eq trans1.credit_card_number
      end
    end

    describe ".find_all_by_invoice_id" do
      it "returns all matching transactions" do
        found = Transaction.find_all_by_invoice_id( trans1.invoice_id )
        expect(found.count).to eq 2
      end
    end

    describe ".find_all_by_by_cc" do
      it "returns all matching transactions" do
        found = Transaction.find_all_by_credit_card_number( trans1.credit_card_number )
        expect(found.count).to eq 2
      end
    end

    describe ".find_all_by_result" do
      it "returns all matching transactions" do
        found = Transaction.find_all_by_result( trans1.result )
        expect(found.count).to eq 1
      end
    end

  end
end