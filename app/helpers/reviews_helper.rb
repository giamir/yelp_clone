module ReviewsHelper
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = (5 - rating)
    "★" * rating.round + "☆" * remainder
  end
end
