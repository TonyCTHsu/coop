class CreatePackageVersion < ActiveRecord::Migration[5.1]
  def change
    create_table :package_versions do |t|
      t.string      :name,    null: false
      t.string      :version, null: false
      t.string      :title
      t.text        :description
      t.string      :maintainer_string
      t.string      :authors_string
      t.timestamp   :published_at
      t.bigint :maintainer_id, index: true
      t.timestamps null: false
    end

    add_index :package_versions, [:name, :version], unique: true

    create_table :authors do |t|
      t.string      :name,    index: { unique: true }, null: false
      t.string      :email
      t.timestamps null: false
    end

    create_join_table :package_versions, :authors do |t|
      t.index :package_version_id
      t.index :author_id
      t.index [:package_version_id, :author_id], name: 'author_package_version_uniq_idx', unique: true
    end
  end
end
