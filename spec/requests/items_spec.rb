require 'spec_helper'

describe "/items/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

    describe "find" do
      it "returns item by id"
      it "returns item by name"
      it "returns item by description"
      it "returns item by unit price"
      it "returns item by merchant id"
    end

    describe "find_all" do
      it "returns items by name"
      it "returns items by description"
      it "returns items by unit price"
      it "returns items by merchant id"
    end

    describe "random" do
      it "returns random item"
    end

    describe ":id/invoice_items" do
      it "returns a collection of associated invoice items"
    end

    describe ":id/merchant" do
      it "returns the associated merchant"
    end

    describe "most_revenue?quantity=x" do
      it "returns the top x items ranked by total revenue generated"
    end

    describe "most_items?quantity=x" do
      it "returns the top x item instances ranked by total number sold"
    end

    describe ":id/best_day" do
      it "returns the date with the most sales for the given item using the invoice date"
    end

end