class CreatePackageAuthorshipsJob < ApplicationJob
  queue_as :default

  def perform(package_version)
    CreatePackageAuthorshipsService.new(package_version).perform
  end
end
