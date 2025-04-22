class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.uuid :uuid
      t.string :title
      t.string :slug
      t.text :html
      t.string :feature_image
      t.boolean :featured
      t.datetime :published_at
      t.text :custom_excerpt
      t.text :excerpt
      t.integer :reading_time
      t.boolean :access
      t.boolean :comments
      t.string :og_image
      t.string :og_title
      t.text :og_description
      t.string :twitter_image
      t.string :twitter_title
      t.text :twitter_description
      t.string :meta_title
      t.text :meta_description
      t.string :email_subject
      t.text :frontmatter
      t.string :feature_image_alt
      t.string :feature_image_caption

      t.timestamps
    end
    add_index :posts, :uuid, unique: true
    add_index :posts, :slug, unique: true
  end
end
