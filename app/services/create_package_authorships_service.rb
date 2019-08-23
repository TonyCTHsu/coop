require 'mail'

class CreatePackageAuthorshipsService
  def initialize(package_version)
    @package_version = package_version
  end

  def perform
    package_version.authors << authors
    package_version.maintainer = maintainer
    package_version.save
  end

  private

  attr_reader :package_version

  def authors
    package_version.author_names.map do |name|
      Author.find_or_initialize_by(name: name)
    end
  end

  def maintainer
    mail = Mail::Address.new(package_version.maintainer_string)

    package_version.authors.find_or_initialize_by(name: mail.name).tap do |author|
      author.update(email: mail.address)
    end
  end
end
