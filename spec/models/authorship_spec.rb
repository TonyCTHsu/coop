require 'rails_helper'

describe Authorship do
  it { is_expected.to belong_to(:package_version) }
  it { is_expected.to belong_to(:author) }
end
