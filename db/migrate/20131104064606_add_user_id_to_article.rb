class AddUserIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :author_id, :string
  end
end
