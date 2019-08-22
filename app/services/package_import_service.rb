class PackageImportService
  def call
    packages = CranService.packages

    PackageVersion.import(
      packages.map(&:to_h),
      on_duplicate_key_ignore: true
    ).tap do |imported_package_versions|
      PackageVersion.where(id: imported_package_versions).each(&:update_info)
    end
  end
end
