require 'spec_helper'

describe "/invoice_items/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

    describe "find" do
      it "returns invoice item by id"
      it "returns invoice item by item id"
      it "returns invoice item by invoice id"
      it "returns invoice item by quantity"
      it "returns invoice item by unit price"
    end

    describe "find_all" do
      it "returns invoice items by item id"
      it "returns invoice items by invoice id"
      it "returns invoice items by quantity"
      it "returns invoice items by unit price"
    end

    describe "random" do
      it "returns random invoice item"
    end

    describe ":id/invoice" do
      it "returns the associated invoice"
    end

    describe ":id/item" do
      it "returns the associated item"
    end

end