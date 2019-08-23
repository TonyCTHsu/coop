class DailyImportPackagesJob < ApplicationJob
  queue_as :default

  def perform
    cran_packages = CranService.new.packages
    service = BatchImportPackagesService.new(cran_packages)

    service.perform
  end
end
