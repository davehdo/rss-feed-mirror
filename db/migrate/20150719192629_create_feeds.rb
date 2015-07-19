class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :original_url
      t.datetime :last_pulled_at
      t.datetime :last_pushed_at
      t.text :last_body
      t.string :last_format

      t.timestamps null: false
    end
  end
end
