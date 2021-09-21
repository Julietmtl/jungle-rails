require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product detail page" do
    # ACT
    visit root_path
    first('article.product h4').click
    
    # VERIFY
    expect(page).to have_current_path(product_path(Product.last))
    expect(page).to have_content("#{@category.name} » #{Product.last.name}")
  end
end
