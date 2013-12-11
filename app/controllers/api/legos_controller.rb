class Api::LegosController < ApplicationController

  http_basic_authenticate_with :name => "brickfever", :password => "brickfever"

  skip_before_filter :authenticate_user! # we do not need devise authentication here

  respond_to :html, :xml, :json

  def get_set_info
    @lego_set = LegoSet.new
    @lego_set.find_set(params[:id] || "10235-1")
  end

  def get_set_parts
    @lego_parts = LegoPart.new
    @lego_parts.find_parts(params[:id] || "10235-1")
  end
  
end
