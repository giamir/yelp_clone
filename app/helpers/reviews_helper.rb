module ReviewsHelper
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
