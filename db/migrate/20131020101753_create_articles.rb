class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :content
      t.string :state

      t.timestamps
    end
  end
end
