class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.pad
  end

  def destroy
    @review = Review.find(params[:id])
    pad = @review.pad
    @review.destroy

    redirect_to pad
  end

  private
    def review_params
      params.require(:review).permit(:comment, :star, :pad_id)
    end
end
