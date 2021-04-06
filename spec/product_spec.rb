require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    @category = Category.create(name: "Shoes")

    it "should have all fields present" do
      product = Product.create(
        :name => 'adidas',
        :price => 300,
        :quantity => 1,
        :category => @category
      )
    end

    it "should have a name" do
      product = Product.create(
        :name => nil,
        :price => 300,
        :quantity => 1,
        :category => @category
      )

      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include 'Name can\'t be blank'
    end

    it "should have a price" do
      product = Product.create(
        :name => 'yeezy',
        :price => nil,
        :quantity => 1,
        :category => @category
      )

      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include 'Price can\'t be blank'
    end

    it "should have a quantiy" do
      product = Product.create(
        :name => 'yeezy',
        :price => nil,
        :quantity => nil,
        :category => @category
      )

      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include 'Quantity can\'t be blank'
    end

    it "should have a category" do
      product = Product.create(
        :name => 'yeezy',
        :price => nil,
        :quantity => nil,
        :category => nil
      )

      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include 'Category can\'t be blank'
    end
  end
end