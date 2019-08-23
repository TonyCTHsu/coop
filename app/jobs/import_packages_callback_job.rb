class ImportPackagesCallbackJob < ApplicationJob
  queue_as :default

  def perform(ids)
    PackageVersion.where(id: ids).each do |package_version|
      UpdatePackageDetailJob.perform_later(package_version)
    end
  end
end
