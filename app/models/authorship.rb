class Authorship < ApplicationRecord
  self.table_name = 'authors_package_versions'

  belongs_to :author
  belongs_to :package_version
end
