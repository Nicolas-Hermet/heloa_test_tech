class AddVisibilityToPosts < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE post_visibility AS ENUM ('public', 'internal');
    SQL
    add_column :posts, :visibility, :post_visibility, default: 'internal'
    add_index :posts, :visibility
  end

  def down
    remove_index :posts, :visibility
    remove_column :posts, :visibility
    execute <<-SQL
     DROP TYPE post_visibility;
    SQL
  end
end
