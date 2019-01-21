require 'rails_helper'

RSpec.describe Product, type: :model do
 
  before :each do
    @category = Category.new(name:"Electronics")
    @product = Product.new(
      name: 'test',
      price: 500,
      quantity: 3,
      category: @category
    )
  end

  describe 'Validations' do
    it "is valid with full information" do 
      expect(@product).to be_valid
    end
    it "is not valid with no name" do 
      @product.name = nil
      expect(@product).to_not be_valid
    end
    it "is not valid with no price" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end
    it "is not valid with no quantity" do
      @product.quantity = nil
      expect(@product).to_not be_valid
    end
    it "is not valid with no category" do
      @product.category = nil
      expect(@product).to_not be_valid
    end
  end
end
