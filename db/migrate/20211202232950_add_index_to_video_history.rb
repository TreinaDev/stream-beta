class AddIndexToVideoHistory < ActiveRecord::Migration[6.1]
  add_index(:video_histories, [:user_id, :video_id], unique: true)
end
