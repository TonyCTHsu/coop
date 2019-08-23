class UpdatePackageDetailJob < ApplicationJob
  queue_as :default

  def perform(package_version)
    UpdatePackageDetailService.new(package_version).perform
  end
end
