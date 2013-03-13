require 'spec_helper'

describe "/transactions/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  let!(:trans1){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'failed', credit_card_number: 4567) }
  let!(:trans2){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'success', credit_card_number: 4567) }
  let!(:trans3){SalesEngineWeb::Transaction.create(invoice_id: 2, result: 'success', credit_card_number: 1234) }

  def get_json(url)
    get url
    JSON.parse(last_response.body)
  end

    describe "find" do
      it "returns transaction by id" do
        output = get_json "/transactions/find?id=#{ trans1.id }"
        expect( output['id'] ).to eq trans1.id
      end

      it "returns transaction by invoice_id" do
        output = get_json "/transactions/find?invoice_id=#{ trans1.invoice_id }"
        expect( output['invoice_id'] ).to eq trans1.invoice_id
      end
      
      it "returns transaction by cc" do
        output = get_json "/transactions/find?credit_card_number=#{ trans1.credit_card_number }"
        expect( output['credit_card_number'] ).to eq trans1.credit_card_number
      end
    end

    describe "find_all" do
      it "returns transactions by invoice_id" do
        output = get_json "/transactions/find_all?invoice_id=#{ trans1.invoice_id }"
        expect( output.count ).to eq 2
      end

      it "returns transactions by result" do
        output = get_json "/transactions/find_all?result=#{ trans1.result }"
        expect( output.count ).to eq 1
      end

      it "returns transaction by cc" do
        output = get_json "/transactions/find_all?credit_card_number=#{ trans1.credit_card_number }"
        expect( output.count ).to eq 2
      end
    end

    describe "random" do
      it "returns random transaction" do
        output = get_json "/transactions/random"
        expect( [ trans1.id, trans2.id, trans3.id ] ).to include( output['id'] )
      end
    end

    describe ":id/invoice" do
      it "returns the associated invoice"
    end

end