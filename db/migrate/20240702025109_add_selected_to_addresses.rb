class AddSelectedToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :selected, :boolean
  end
end
