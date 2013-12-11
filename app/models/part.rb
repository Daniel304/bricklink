class part
  include ActiveModel::Model
  belongs_to :set  
  
  attr_accessor :id, :quantity, :item_id, :name, :image, :colorid, :description, :release_year, :weight, :dimensions
end
