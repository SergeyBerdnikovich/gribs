class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :name
      t.string :titile
      t.text :content
      t.string :slug
      t.timestamps
    end
  end
end
