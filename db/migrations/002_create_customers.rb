Sequel.migration do
  change do
    create_table :customers do
      primary_key :id
      String      :first_name
      String      :last_name
      DateTime    :created_at
      DateTime    :updated_at 
    end
  end
end