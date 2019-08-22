class PackageVersion < ApplicationRecord
  has_many :authorships
  has_many :authors, through: :authorships
  belongs_to :maintainer, class_name: 'Author', foreign_key: 'maintainer_id', optional: true

  def update_info
    description = CranService.description(self)

    update(description.to_h)
  end

  def path
    "#{name}_#{version}"
  end
end
