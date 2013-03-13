require 'spec_helper'

describe "/customers/" do
  include Rack::Test::Methods

  def app
    SalesEngineWeb::Server
  end

  let(:customer1){ SalesEngineWeb::Customer.create(:first_name => "Geoff", :last_name => "Schorkopf") }
  let!(:customer2){ SalesEngineWeb::Customer.create(:first_name => "Tim", :last_name => "Schorkopf") }

  describe "find" do
    it "returns customer by id" do
      get "/customers/find?id=#{customer1.id}"
      result = JSON.parse(last_response.body)
      expect( result['id'] ).to eq customer1.id
      expect( result['first_name'] ).to eq customer1.first_name
    end

    it "returns customer by first name" do
      get "/customers/find?first_name=#{customer1.first_name}"
      result = JSON.parse(last_response.body)
      expect( result['first_name'] ).to eq customer1.first_name
    end

    it "returns customer by last name" do 
      get "/customers/find?last_name=#{customer1.last_name}"
      result = JSON.parse(last_response.body)
      expect( result['last_name'] ).to eq customer1.last_name
    end
  end

  describe "find_all" do
    it "returns customers by first name" do
      get "/customers/find_all?first_name=#{customer1.first_name}"
      output = JSON.parse(last_response.body)
      expect( output.count ).to eq 1
    end

    it "returns customers by last name" do 
      get "/customers/find_all?last_name=#{customer1.last_name}"
      results = JSON.parse(last_response.body)
      expect( results.count ).to eq 2
    end
  end

  describe "random" do
    it "returns random customer" do
      get '/customers/random'
      output = JSON.parse(last_response.body)
      expect( [ customer1.id, customer2.id ] ).to include( output['id'] )
    end
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