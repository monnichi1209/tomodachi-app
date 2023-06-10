class AddContertToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :content, :text
  end
end
