class Author < ApplicationRecord
  has_many :authorships
  has_many :package_versions, through: :authorships
end
