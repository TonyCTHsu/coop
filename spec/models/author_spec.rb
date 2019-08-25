require 'rails_helper'

describe Author do
  it { is_expected.to have_many(:authorships) }
  it { is_expected.to have_many(:package_versions).through(:authorships) }
end
