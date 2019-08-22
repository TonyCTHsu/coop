class PackageVersion < ApplicationRecord
  def update_info
    description = CranService.description(self)

    update(description.to_h)
  end

  def path
    "#{name}_#{version}"
  end
end
