class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :content, :limit => nil
      t.string :state

      t.timestamps
    end
  end
end
