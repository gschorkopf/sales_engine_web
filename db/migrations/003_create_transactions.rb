Sequel.migration do
  change do
    create_table :transactions do
      primary_key   :id
      foreign_key   :invoice_id
      Integer       :credit_card_number
      DateTime      :credit_card_expiration_date
      #we never really use this stuff. needed?
      String        :result
      DateTime      :created_at
      DateTime      :updated_at 
    end
  end
end