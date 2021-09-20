require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    before do 
      @category = Category.new(name: "Electronics")
      @product = Product.new(name: "cellphone", price_cents: 2000, quantity: 1, category: @category)
    end

    it 'is valid with all the fields' do
      @product.valid?
      @product.errors.full_messages
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @product.name = nil
      @product.valid?
      @product.errors.full_messages
      expect(@product).to_not be_valid
    end

    it 'is not valid without a price' do
      @product.price_cents = nil
      @product.valid?
      @product.errors.full_messages
      expect(@product).to_not be_valid
    end

    it 'is not valid without a price' do
      @product.quantity = nil
      @product.valid?
      @product.errors.full_messages
      expect(@product).to_not be_valid
    end

    it 'is not valide without a category' do
      @product.category = nil
      @product.valid?
      @product.errors.full_messages
      expect(@product).to_not be_valid
    end
  end
end
