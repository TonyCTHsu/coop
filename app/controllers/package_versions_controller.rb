class PackageVersionsController < ApplicationController
  def index
    @package_versions = PackageVersion.page(params[:page] || 1).per(10)
  end
end
