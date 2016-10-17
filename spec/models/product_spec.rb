require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    category_no_name = Category.new
    product_no_name = Product.new(category: category_no_name, price: 100.00, quantity: 1)

    category_no_price = Category.new
    product_no_price = Product.new(category: category_no_price, name: 'some product', quantity: 1)

    category_no_quantity = Category.new
    product_no_quantity = Product.new(category: category_no_quantity, name: 'some product', price: 100.00)

    product_no_category = Product.new(name: 'some product', price: 100.00, quantity: 1)

    it 'should reject a product lacking a name' do
      product_no_name.save
      expect(product_no_name).to_not(be_persisted)
      expect(product_no_name.errors.size).to eql(1)
      expect(product_no_name.errors.full_messages).to include "Name can't be blank"
    end

    it 'should reject a product lacking a price' do
      product_no_price.save
      expect(product_no_price).to_not(be_persisted)
      expect(product_no_price.errors.size).to eql(3)
      expect(product_no_price.errors.full_messages).to include "Price cents is not a number"
      expect(product_no_price.errors.full_messages).to include "Price is not a number"
      expect(product_no_price.errors.full_messages).to include "Price can't be blank"
    end

    it 'should reject a product lacking a quantity' do
      product_no_quantity.save
      expect(product_no_quantity).to_not(be_persisted)
      expect(product_no_quantity.errors.size).to eql(1)
      expect(product_no_quantity.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'should reject a product lacking a category' do
      product_no_category.save
      expect(product_no_category).to_not(be_persisted)
      expect(product_no_category.errors.size).to eql(1)
      expect(product_no_category.errors.full_messages).to include "Category can't be blank"
    end

  end
end
