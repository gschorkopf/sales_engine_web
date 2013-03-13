module SalesEngineWeb
  class Server < Sinatra::Base
    get '/' do
      "Hello world"
    end

    get '/merchants/find' do
      if params[:id]
        merchant = Merchant.find(params[:id])
      else
        merchant = Merchant.find_by_name(params[:name])
      end
      body merchant.to_json
    end

    get '/merchants/find_all' do
      merchants = Merchant.find_all_by_name(params[:name])
      body merchants.to_json
    end

    get '/merchants/random' do
      Merchant.random.to_json
    end

    get '/invoices/find' do
      if params[:id]
        invoice = Invoice.find(params[:id])
      elsif params[:customer_id]
        invoice = Invoice.find(params[:customer_id])
      elsif params[:merchant_id]
        invoice = Invoice.find(params[:merchant_id])
      end
      body invoice.to_json
    end

    get '/invoices/find_all' do
      if params[:customer_id]
        invoices = Invoice.find_all_by_customer_id(params[:customer_id])
      elsif params[:merchant_id]
        invoices = Invoice.find_all_by_merchant_id(params[:merchant_id])
      elsif params[:status]
        invoices = Invoice.find_all_by_status(params[:status])
      end
      body invoices.to_json 
    end

    get '/invoices/random' do
      Invoice.random.to_json
    end

    get '/customers/find' do
      if params[:id]
        customer = Customer.find(params[:id])
      elsif params[:first_name]
        customer = Customer.find_by_first_name(params[:first_name])
      else
        customer = Customer.find_by_last_name(params[:last_name])
      end
      body customer.to_json
    end

    get '/customers/find_all' do
      if params[:first_name]
        customers = Customer.find_all_by_first_name(params[:first_name])
      else
        customers = Customer.find_all_by_last_name(params[:last_name])
      end
      body customers.to_json
    end

    get '/customers/random' do
      Customer.random.to_json
    end

    get '/items/find' do
      if params[:id]
        item = Item.find(params[:id])
      elsif params[:name]
        item = Item.find_by_name(params[:name])
      elsif params[:description]
        item = Item.find_by_description(params[:description])
      elsif params[:unit_price]
        item = Item.find_by_unit_price(params[:unit_price])        
      elsif params[:merchant_id]
        item = Item.find_by_merchant_id(params[:merchant_id])
      end
      body item.to_json
    end

    get '/items/find_all' do
      if params[:name]
        items = Item.find_all_by_name(params[:name])
      elsif params[:description]
        items = Item.find_all_by_description(params[:description])
      elsif params[:unit_price]
        items = Item.find_all_by_unit_price(params[:unit_price])        
      elsif params[:merchant_id]
        items = Item.find_all_by_merchant_id(params[:merchant_id])
      end
      body items.to_json
    end

    get '/items/random' do
      Item.random.to_json
    end


  end
end