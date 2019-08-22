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
      t.timestamps null: false
    end
    add_index :package_versions, [:name, :version], unique: true
  end
end
