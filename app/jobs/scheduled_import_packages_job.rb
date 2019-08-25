class ScheduledImportPackagesJob < ApplicationJob
  def perform
    cran_packages = CranService.new.packages
    service = BatchImportPackagesService.new(cran_packages)

    service.perform
  end
end
