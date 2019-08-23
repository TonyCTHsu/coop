class UpdatePackageDetailService
  def initialize(package_version)
    @package_version = package_version
  end

  def perform
    package_version.update!(description.to_h).tap do
      CreatePackageAuthorshipsJob.perform_later(package_version)
    end
  end

  private

  attr_reader :package_version

  def description
    @description ||= CranService.description(package_version)
  end
end
