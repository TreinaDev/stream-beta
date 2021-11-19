class AddStreamerReferenceToVideo < ActiveRecord::Migration[6.1]
  def change
    add_reference :videos, :streamer, null: false, foreign_key: true
  end
end
