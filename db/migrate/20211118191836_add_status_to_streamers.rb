class AddStatusToStreamers < ActiveRecord::Migration[6.1]
  def change
    add_column :streamers, :status, :integer, default: 0
  end
end
