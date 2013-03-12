require 'spec_helper'

describe "/customers/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

    describe "find" do
      it "returns customer by id"
      it "returns customer by first name"
      it "returns customer by last name"
    end

    describe "find_all" do
      it "returns customers by first name"
      it "returns customers by last name"
    end

    describe "random" do
      it "returns random customers"
    end

    describe ":id/invoices" do
      it "returns a collection of associated invoices"
    end
    
    describe ":id/transactions" do
      it "returns a collection of associated transactions"
    end

    describe ":id/favorite_merchant" do
      it "returns a merchant where the customer has conducted the most successful transactions"
    end

end