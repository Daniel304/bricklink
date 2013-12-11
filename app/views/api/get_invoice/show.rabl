object @lego_invoice

attributes :id, :order_date, :payment_by, :payment_in, :order_status, :changed, :total_items, :unique_items, :invoiced, :order_total,
           :shipping, :insurance, :additional_charges_1, :additional_charges_2, :credit, :grand_total, :orders_in_this_store

node(:items) do |u|
  item = u.items
end

attributes :buyer
attributes :seller
