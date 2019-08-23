class ImportPackagesService
  def initialize(cran_packages_data)
    @cran_packages_data = cran_packages_data
  end

  def perform
    PackageVersion.import(
      @cran_packages_data, on_duplicate_key_ignore: true
    ).tap do |result|
      ImportPackagesCallbackJob.perform_later(result.ids)
    end
  end
end
