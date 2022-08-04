class SalonInfosController < ApplicationController
  def new
    @salon_info = SalonInfo.new()
  end
end