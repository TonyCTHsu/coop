RSpec::Matchers.define :a_collection_length_of do |x|
  match { |actual| actual.length == x }
end
