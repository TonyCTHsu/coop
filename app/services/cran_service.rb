require 'rubygems/package'
require 'zlib'
require 'dcf'

class CranService
  def self.packages
    Dcf.parse(client.get('PACKAGES').body).map do |hash|
      Cran::Package.new(hash)
    end
  end

  def self.description(package, extension: '.tar.gz')
    response = client.get(package.path + extension)
    description_content = nil

    Tempfile.open([package.path, '.tar.gz'], encoding: 'ascii-8bit') do |f|
      f.write(response.body)
      f.rewind

      Gem::Package::TarReader.new(Zlib::GzipReader.open(f.path)) do |tar|
        tar.each do |entry|
          description_content = entry.read if entry.full_name.ends_with?('/DESCRIPTION')
        end
      end
    end

    Cran::Description.new(Dcf.parse(description_content).first)
  end

  def self.client
    CranClient.new
  end
end
