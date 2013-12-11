class Api::GetInvoicesController < ApplicationController

  http_basic_authenticate_with :name => "bricklink", :password => "bricklink"

  skip_before_filter :authenticate_user! # we do not need devise authentication here

  respond_to :html, :xml, :json

  def index
    @lego_invoices = LegoInvoices.new
    @lego_invoices.find_invoices(params[:username], params[:password])
  end
  
end
