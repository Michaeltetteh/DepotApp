require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures  :products


  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    product = Product.new(
      title: "Some Title here",
      description: "Some description here",
      image_url: "img_test.jpg"
    )
    
    # product.price = -1
    # assert product.invalid?
    # assert_equal ["must be greater than or equal to 0.01"],
    # product.errors[:price]
    
    # product.price = 0
    # assert product.invalid?
    # assert_equal ["must be greater than or equal to 0.01"],
    # product.errors[:price]

    product.price = 1
    assert product.valid?

  end

  def new_product(image_url)
    product = Product.new(
      title: "Some title here again",
      description: "Some description here again",
      image_url: image_url,
      price: 1
    )
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.jpeg fred.png fred.JPG fred.JPEG http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc fred.gi/more fred.gif.more}
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(
      title:        products(:ruby).title,  #load the same title from the ruby fixture
      description:  "fsda",
      image_url:    "fred.gif",
      price:        1
    )
    assert product.invalid? # the title of each product must be unique
    assert_equal ["has already been taken"], product.errors[:title]
  end

  # test "product is not valid without a unique title - i18n" do
  #   product = Product.new(
  #     title:  products(:ruby).title,
  #     description:  "yyy",
  #     price:  1,
  #     image_url:  "fred.gif"
  #   )  
  #   assert product.invalid?
  #   assert_equal [I18n.translate('errors.messages.taken')],
  #   product.errors[:title]
  # end

  test "title is greater than or equal to 10" do
    product = Product.new(
      title:        "title",
      description:  "fsda",
      image_url:    "fred.gif",
      price:        1
    )
    if (product.title.length >= 10)
      assert product.valid?, "Title is valid"
      # assert_equal ["title is greater or equal to 10"], product.errors[:title]
    else
      assert product.invalid?,'Title is invalid'
      # assert_equal ["title is less than 10"], product.errors[:title]
    end
  end

end
