require 'spec_helper'

describe "/customers/" do
  include Rack::Test::Methods
  include_context "standard test dataset"

  def app
    SalesEngineWeb::Server
  end

  def get_json(url)
    get url
    JSON.parse(last_response.body)
  end
  
  describe "find" do
    it "returns customer by id" do
      result = get_json "/customers/find?id=#{customer1.id}"
      expect( result['id'] ).to eq customer1.id
      expect( result['first_name'] ).to eq customer1.first_name
    end

    it "returns customer by first name" do
      result = get_json "/customers/find?first_name=#{customer1.first_name}"
      expect( result['first_name'] ).to eq customer1.first_name
    end

    it "returns customer by last name" do 
      result = get_json "/customers/find?last_name=#{customer1.last_name}"
      expect( result['last_name'] ).to eq customer1.last_name
    end
  end

  describe "find_all" do
    it "returns customers by first name" do
      results = get_json "/customers/find_all?first_name=#{customer1.first_name}"
      expect( results.count ).to eq 1
    end

    it "returns customers by last name" do 
      results = get_json "/customers/find_all?last_name=#{customer1.last_name}"
      expect( results.count ).to eq 2
    end
  end

  describe "random" do
    it "returns random customer" do
      output = get_json '/customers/random'
      expect( [ customer1.id, customer2.id ] ).to include( output['id'] )
    end
  end

  describe ":id/invoices" do
    it "returns a collection of associated invoices" do
      output = get_json "/customers/#{customer1.id}/invoices"
      expect(output.count).to eq 2
    end
  end
  
  describe ":id/transactions" do
    it "returns a collection of associated transactions" do
      output = get_json "/customers/#{customer1.id}/transactions"
      expect(output.count).to eq 3
    end
  end

  describe ":id/favorite_merchant" do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      output = get_json "/customers/#{customer1.id}/favorite_merchant"
      expect(output['name']).to eq 'gSchool'
    end
  end

end