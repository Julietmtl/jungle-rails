require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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
    first('button').click

    #DEBUG
    sleep 5
    save_screenshot
    
    # VERIFY
    expect(page).to have_content 'My Cart (1)'
  end
end
