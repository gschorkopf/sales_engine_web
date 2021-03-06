module SalesEngineWeb
  class Server < Sinatra::Base
    set :views, 'lib/sales_engine_web/views'

    get '/' do
      @customers = Customer.all
      erb :index
    end

    # module SalesEngineWeb

    #   def self.class_for_csv_type(csv_type)
    #     if csv_type.downcase == "customer"
    #       Customer
    #     else
    #       UnknownType
    #     end
    #   end

    #   class UnknownType
    #     def self.create(*params)
    #       raise "I am not the appropriate type to handle requests"
    #     end
    #   end
    # end


    post '/upload' do
      filename = "./db/csvs/#{params[:csv_file]}"
      csv_file = CSV.open(filename, headers: true, header_converters: :symbol)
      csv_file.collect do |file_row|
        SalesEngineWeb.const_get( params[:csv_type] ).create(file_row)
      end
      redirect to('/')
    end

    def respond_with(response)
      status response.status
      body response.body
    end

    get '/merchants/find' do
      respond_with MerchantsController.find(params)
    end

    get '/merchants/find_all' do
      respond_with MerchantsController.find_all(params)
    end

    get '/merchants/random' do
      Merchant.random.to_json
    end

    get '/merchants/:id/items' do
      Merchant.find(params[:id]).items.to_json Merchant.find(params[:id])
    end
    
    get '/merchants/:id/invoices' do
      Merchant.find(params[:id]).invoices.to_json if Merchant.find(params[:id])
    end

    get '/merchants/:id/revenue' do
      rev = Merchant.find(params[:id]).revenue if Merchant.find(params[:id])
      body rev.to_s
    end

    get '/merchants/:id/favorite_customer' do
      Merchant.find(params[:id]).favorite_customer.to_json if Merchant.find(params[:id])
    end

    get '/merchants/:id/customers_with_pending_invoices' do
      Merchant.find(params[:id]).customers_with_pending_invoices.to_json
    end

    get '/merchants/most_revenue' do
      Merchant.most_revenue(params[:quantity]).to_json
    end

    get '/merchants/most_items' do
      Merchant.most_items(params[:quantity]).to_json
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

    # [ [ "merchants", Merchants ], [ "invoices", Invoices] ].each do |model,model_class|
    #   get "/#{model}/random" do
    #     model_class.random.to_json
    #   end
    # end

    get '/merchants/random' do
      Merchant.random.to_json
    end

    get '/invoices/random' do
      Invoice.random.to_json
    end

    get '/invoices/:id/transactions' do
      Invoice.find(params[:id]).transactions.to_json if Invoice.find(params[:id])
    end

    get '/invoices/:id/invoice_items' do
      Invoice.find(params[:id]).invoice_items.to_json if Invoice.find(params[:id])
    end

    get '/invoices/:id/items' do
      Invoice.find(params[:id]).items.to_json if Invoice.find(params[:id])
    end

    get '/invoices/:id/customer' do
      Invoice.find(params[:id]).customer.to_json if Invoice.find(params[:id])
    end

    get '/invoices/:id/merchant' do
      Invoice.find(params[:id]).merchant.to_json if Invoice.find(params[:id])
    end

    get '/customers/find' do
      if params[:id]
        customer = Customer.find(params[:id])
      elsif params[:first_name]
        customer = Customer.find_by_first_name(params[:first_name])
      elsif params[:last_name]
        customer = Customer.find_by_last_name(params[:last_name])
      end
      body customer.to_json
    end

    get '/customers/find_all' do
      if params[:first_name]
        customers = Customer.find_all_by_first_name(params[:first_name])
      elsif params[:last_name]
        customers = Customer.find_all_by_last_name(params[:last_name])
      end
      body customers.to_json
    end

    get '/customers/random' do
      Customer.random.to_json
    end

    get '/customers/:id/invoices' do
      Customer.find(params[:id]).invoices.to_json if Customer.find(params[:id])
    end 

    get '/customers/:id/transactions' do
      Customer.find(params[:id]).transactions.to_json if Customer.find(params[:id])
    end

    get '/customers/:id/favorite_merchant' do
      Customer.find(params[:id]).favorite_merchant.to_json
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

    get '/items/:id/invoice_items' do
      Item.find(params[:id]).invoice_items.to_json if Item.find(params[:id])
    end

    get '/items/:id/merchant' do
      Item.find(params[:id]).merchant.to_json if Item.find(params[:id])
    end

    get '/items/most_items' do
      Item.most_items(params[:quantity]).to_json
    end

    get '/items/most_revenue' do
      Item.most_revenue(params[:quantity]).to_json
    end

    get '/invoice_items/find' do
      if params[:id]
        ii = InvoiceItem.find(params[:id])
      elsif params[:item_id]
        ii = InvoiceItem.find_by_item_id(params[:item_id])
      elsif params[:invoice_id]
        ii = InvoiceItem.find_by_invoice_id(params[:invoice_id])
      elsif params[:quantity]
        ii = InvoiceItem.find_by_quantity(params[:quantity])
      elsif params[:unit_price]
        ii = InvoiceItem.find_by_unit_price(params[:unit_price])
      end  
      body ii.to_json     
    end

    get '/invoice_items/find_all' do
      if params[:item_id]
        iis = InvoiceItem.find_all_by_item_id(params[:item_id])
      elsif params[:invoice_id]
        iis = InvoiceItem.find_all_by_invoice_id(params[:invoice_id])
      elsif params[:quantity]
        iis = InvoiceItem.find_all_by_quantity(params[:quantity])
      elsif params[:unit_price]
        iis = InvoiceItem.find_all_by_unit_price(params[:unit_price])
      end  
      body iis.to_json
    end

    get '/invoice_items/random' do
      InvoiceItem.random.to_json
    end

    get '/invoice_items/:id/invoice' do
      InvoiceItem.find(params[:id]).invoice.to_json if InvoiceItem.find(params[:id])
    end 

    get '/invoice_items/:id/item' do
      InvoiceItem.find(params[:id]).item.to_json if InvoiceItem.find(params[:id])
    end

    get '/transactions/find' do
      if params[:id]
        trans = Transaction.find(params[:id])
      elsif params[:invoice_id]
        trans = Transaction.find_by_invoice_id(params[:invoice_id])
      elsif params[:credit_card_number]
        trans = Transaction.find_by_credit_card_number(params[:credit_card_number])
      end
      body trans.to_json
    end

    get '/transactions/find_all' do
      if params[:result]
        trans = Transaction.find_all_by_result(params[:result])
      elsif params[:invoice_id]
        trans = Transaction.find_all_by_invoice_id(params[:invoice_id])
      elsif params[:credit_card_number]
        trans = Transaction.find_all_by_credit_card_number(params[:credit_card_number])
      end
      body trans.to_json
    end

    get '/transactions/random' do
      Transaction.random.to_json
    end

    get '/transactions/:id/invoice' do
      Transaction.find(params[:id]).invoice.to_json if Transaction.find(params[:id])
    end

    not_found do
      erb :error
    end

  end
end