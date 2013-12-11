BlapiDaniel304Nl::Application.routes.draw do

  namespace :api do
    resources :get_set_info
    resources :get_set_parts
    resources :get_invoices
    resources :get_invoice
    resources :put_store_content
  end

end
