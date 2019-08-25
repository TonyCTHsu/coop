require 'rails_helper'

describe Cran::Description do
  describe '#to_h' do
    it 'returns a hash' do
      cran_description = described_class.new(
        'Title' => 'title',
        'Description' => 'description',
        'Date/Publication' => 'published_at',
        'Maintainer' => 'maintainer',
        'Author' => 'authors'
      )

      expect(cran_description.to_h).to eq(
        title: 'title',
        description: 'description',
        published_at: 'published_at',
        maintainer_string: 'maintainer',
        authors_string: 'authors'
      )
    end
  end
end
