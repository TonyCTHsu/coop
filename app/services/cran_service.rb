require 'rubygems/package'
require 'zlib'
require 'dcf'

class CranService
  PACKAGES_PATH = 'PACKAGES'.freeze
  PACKAGE_EXTENSION = '.tar.gz'.freeze
  DESCRIPTION_FILENAME = '/DESCRIPTION'.freeze

  attr_accessor :client

  def initialize(client = CranClient.new)
    @client = client
  end

  def packages
    Dcf.parse(client.get(PACKAGES_PATH).body).map do |package_data|
      Cran::Package.new(package_data)
    end
  end

  def description(package)
    description_data = nil

    response = client.get(package.path + PACKAGE_EXTENSION)

    Tempfile.open([package.path, PACKAGE_EXTENSION], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Gem::Package::TarReader.new(Zlib::GzipReader.open(f.path)) do |tar|
        tar.each do |entry|
          description_data = entry.read if entry.full_name.ends_with?(DESCRIPTION_FILENAME)
        end
      end
    end

    Cran::Description.new(Dcf.parse(description_data).first)
  end
end
