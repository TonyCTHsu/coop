class Author < ApplicationRecord
  has_many :authorships
  has_many :package_versions, through: :authorships

  def path
    "#{name}_#{version}"
  end
end
