class BatchImportPackagesService
  def initialize(cran_packages)
    @cran_packages = cran_packages
  end

  def perform(batch_size: 1000)
    @cran_packages.each_slice(batch_size) do |batch|
      ImportPackagesService.new(batch.map(&:to_h)).perform
    end
  end
end
