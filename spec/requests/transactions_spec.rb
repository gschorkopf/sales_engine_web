require 'spec_helper'

describe "/transactions/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

    describe "find" do
      it "returns transaction by id"
      it "returns transaction by invoice_id"
      it "returns transaction by cc"
      it "returns transaction by cc expiry"
    end

    describe "find_all" do
      it "returns transactions by invoice_id"
      it "returns transactions by cc"
      it "returns transactions by cc expiry"
      it "returns transactions by result"
    end

    describe "random" do
      it "returns random transaction"
    end

    describe ":id/invoice" do
      it "returns the associated invoice"
    end

end