class PackageVersion < ApplicationRecord
  has_many :authorships
  has_many :authors, through: :authorships
  belongs_to :maintainer, class_name: 'Author', foreign_key: 'maintainer_id', optional: true

  def path
    "#{name}_#{version}"
  end

  def author_names
    authors_string.
      gsub(/\[.*?\]|\(.*?\)|\<.*?\>/, '').
      gsub(', ', '||').
      gsub(' and ', '||').
      split('||').
      map(&:squish)
  end
end
