class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :feature_image
      t.string :og_image
      t.string :og_title_string
      t.string :meta_title
      t.text :meta_description
      t.string :url

      t.timestamps
    end
    add_index :tags, :slug, unique: true
  end
end
