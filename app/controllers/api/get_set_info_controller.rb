class Api::GetSetInfoController < ApplicationController

  http_basic_authenticate_with :name => "brickfever", :password => "brickfever"

  skip_before_filter :authenticate_user! # we do not need devise authentication here

  respond_to :html, :xml, :json

  def show
    @lego_set = LegoSet.new
    @lego_set.find_set(params[:id] || "10235-1")
  end
  
end
