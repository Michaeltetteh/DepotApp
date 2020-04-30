class StoreController < ApplicationController
  include CurrentCart

  before_action :sess_counter, only: [:index]

  def index
    @products = Product.order(:title)
  end
end

