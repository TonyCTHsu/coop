class Author < ApplicationRecord
  has_many :authorships
  has_many :package_versions, through: :authorships

  def update_info
    description = CranService.description(self)

    update(description.to_h)
  end

  def path
    "#{name}_#{version}"
  end
end
