class Api::GetInvoiceController < ApplicationController

  http_basic_authenticate_with :name => "brickfever", :password => "brickfever"

  skip_before_filter :authenticate_user! # we do not need devise authentication here

  respond_to :html, :xml, :json

  def show
    @lego_invoice = LegoInvoice.new
    logger.info @lego_invoice.find_invoice(params[:username], params[:password], params[:id]).to_yaml
  end
  
end
