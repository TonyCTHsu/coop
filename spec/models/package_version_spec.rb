require 'rails_helper'

describe PackageVersion do
  it { is_expected.to have_many(:authorships) }
  it { is_expected.to have_many(:authors).through(:authorships) }
  it do
    is_expected.to belong_to(:maintainer).
      class_name('Author').
      with_foreign_key(:maintainer_id).
      optional
  end

  describe '#path' do
    it 'returns an url path for CRAN' do
      package_version = described_class.new(name: 'A3', version: '0.0.1')

      expect(package_version.path).to eq('A3_0.0.1')
    end
  end

  describe '#author_names' do
    context 'when containes brackets and parentheses' do
      it 'returns a list of names' do
        package_version = described_class.new(
          authors_string:
            "Jiawei Bai [cre, aut] (<https://orcid.org/0000-0003-4021-0101>), "\
            "John Muschelli [ctb] (<https://orcid.org/0000-0001-6469-1750>)"
        )

        expect(package_version.author_names).to contain_exactly(
          'Jiawei Bai',
          'John Muschelli'
        )
      end
    end

    context 'when containes `and`' do
      it 'returns a list of names' do
        package_version = described_class.new(
          authors_string: 'Hasinur Rahaman Khan and Ewart Shaw'
        )

        expect(package_version.author_names).to contain_exactly(
          'Hasinur Rahaman Khan',
          'Ewart Shaw'
        )
      end
    end

    context 'when splits by `,`' do
      it 'returns a list of names' do
        package_version = described_class.new(
          authors_string: 'William Shannon, Tao Li, Hong Xian, Jia Wang, Elena Deych, Carlos Gonzalez'
        )

        expect(package_version.author_names).to contain_exactly(
          'William Shannon',
          'Tao Li',
          'Hong Xian',
          'Jia Wang',
          'Elena Deych',
          'Carlos Gonzalez'
        )
      end
    end

    context 'when contains brackets' do
      it 'returns a list of names' do
        package_version = described_class.new(
          authors_string: 'Andreas Kiermeier [aut, cre], Peter Bloomfield [ctb]'
        )

        expect(package_version.author_names).to contain_exactly(
          'Andreas Kiermeier',
          'Peter Bloomfield',
        )
      end
    end
  end
end
