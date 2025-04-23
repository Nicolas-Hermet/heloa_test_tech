class CreatePrimaryPostsTags < ActiveRecord::Migration[7.1]
  def change
    create_table :primary_posts_tags do |t|
      t.references :post, null: false, foreign_key: true, index: { unique: true }
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
