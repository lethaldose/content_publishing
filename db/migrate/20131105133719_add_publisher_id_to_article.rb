class AddPublisherIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :publisher_id, :integer
  end
end
