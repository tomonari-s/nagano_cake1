class Delivery < ApplicationRecord
  belongs_to :customer
  
  def delivery_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
  
end


