class AddPushUrlToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :push_url, :string
  end
end
