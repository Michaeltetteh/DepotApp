class CopyProductPriceToLineItems < ActiveRecord::Migration[5.2]

  def up
    LineItem.all.each do |line_item|
      product = Product.find(line_item.product_id)
      line_item.price = product.price
      line_item.save!
    end
  end

  def down
    LineItem.all.each do |line_item|
      line_item.price = nill
      line_item.save!
    end
  end

  def change
    add_column :line_items, :price, :integer
  end
end
