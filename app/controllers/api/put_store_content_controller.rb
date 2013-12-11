class Api::PutStoreContentController < ApplicationController

  http_basic_authenticate_with :name => "bricklink", :password => "bricklink"

  skip_before_filter :authenticate_user! # we do not need devise authentication here

  respond_to :html, :xml, :json

  def update
    logger.info "test"
    logger.info params[:items].to_yaml
    logger.info "test"
  end
  
end
