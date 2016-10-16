class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)

    @review.user_id = current_user.id
    @review.product_id = @product.id

    if @review.save
      redirect_to product_path(@product)
    else
      render product_path(@product)
    end

    # redirect_to  @product
  end

  def destroy
    @review = Review.find params[:id]
    @product = Product.find(params[:product_id])

    if @review.user_id == current_user.id
      @review.destroy
      redirect_to product_path(@product), notice: 'Comment deleted!'
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
