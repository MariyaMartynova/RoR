class Cart < ActiveRecord::Base
   has_many :products, :through=>:cart_items
   has_many :cart_items, :dependent => :destroy

   def total
    cart_items.inject(0) {|sum,n| n.product.price*n.amount + sum }
   end
   def add(product_id)
     items=cart_items.find_all_by_product_id(product_id)
     product=Product.find(product_id)
     if items.size<1
       cart_items.create!(:product_id=>product_id, :amount=>1)
     else
       ci=items.first
       ci.update_attribute(:amount, ci.amount+1)
     end
     
   end
   def destroy_cart_items
    cart_items do |cart_item|
     cart_item.destroy 
    end
   end
   
   def total_amount
     cart_items.inject(0) {|sum,n| n.amount + sum }
   end
   
end
