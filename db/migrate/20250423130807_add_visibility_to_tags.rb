class AddVisibilityToTags < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE tag_visibility AS ENUM ('public', 'internal');
    SQL
    add_column :tags, :visibility, :tag_visibility, default: 'internal'
    add_index :tags, :visibility
  end

  def down
    remove_index :tags, :visibility
    remove_column :tags, :visibility
    execute <<-SQL
     DROP TYPE tag_visibility;
    SQL
  end
end
