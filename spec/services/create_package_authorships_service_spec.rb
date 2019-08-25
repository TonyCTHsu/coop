require 'rails_helper'

describe CreatePackageAuthorshipsService do
  describe '#perfrom' do
    it do
      package_version = PackageVersion.create(
        name: "ABCp2",
        version: "1.2",
        maintainer_string: "M. Catherine Duryea <katie.duryea@gmail.com>",
        authors_string: "M. Catherine Duryea, Andrew D. Kern, Robert M. Cox, and Ryan Calsbeek",
      )

      service = described_class.new(package_version)
      expect do
        service.perform
      end.to change { package_version.reload.authors.length }.from(0).to(4)

      expect(package_version.maintainer.name).to eq('M. Catherine Duryea')
      expect(package_version.maintainer.email).to eq('katie.duryea@gmail.com')
    end

    context 'when author already exists' do
      it 'creates associations with the existing one' do
        Author.create(name: 'M. Catherine Duryea')
        package_version = PackageVersion.create(
          name: "ABCp2",
          version: "1.2",
          maintainer_string: "M. Catherine Duryea <katie.duryea@gmail.com>",
          authors_string: "M. Catherine Duryea, Andrew D. Kern, Robert M. Cox, and Ryan Calsbeek",
        )

        service = described_class.new(package_version)
        expect do
          service.perform
        end.to change { Author.count }.by(3)

        expect(package_version.maintainer.name).to eq('M. Catherine Duryea')
        expect(package_version.maintainer.email).to eq('katie.duryea@gmail.com')
      end
    end
  end
end
