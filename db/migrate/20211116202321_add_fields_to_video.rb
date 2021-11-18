class AddFieldsToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :duration, :string
    add_column :videos, :video_url, :string
    add_column :videos, :maturity_rating, :string
  end
end
