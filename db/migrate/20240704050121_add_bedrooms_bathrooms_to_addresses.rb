class AddBedroomsBathroomsToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :bedrooms, :integer
    add_column :addresses, :bathrooms, :integer
  end
end
