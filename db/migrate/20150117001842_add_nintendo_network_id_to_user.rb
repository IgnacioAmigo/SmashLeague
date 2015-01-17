class AddNintendoNetworkIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :nintendo_network_id, :string
  end
end
