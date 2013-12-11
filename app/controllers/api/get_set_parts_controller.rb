class Api::GetSetPartsController < ApplicationController

  http_basic_authenticate_with :name => "brickfever", :password => "brickfever"

  skip_before_filter :authenticate_user! # we do not need devise authentication here

  respond_to :html, :xml, :json

  def show
    @lego_part = LegoPart.new
    @lego_part.find_parts(params[:id] || "10235-1")
  end
  
end
