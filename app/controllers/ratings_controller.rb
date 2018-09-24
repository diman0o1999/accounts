class RatingsController < ApplicationController

  def new
    @article = Article.find(params[:article_id])
    @rating  = Rating.new
  end

  def create
    @article = Article.find(params[:article_id])
    @rating= Rating.new(rating_params)
    @rating.ratingable = @article
    @rating.user = current_user

    if @rating.save
      # установить значение  в поле рейтинг rails average
      #
      avg = @article.ratings.average(:mark).round
      @article.update_column(:rating, avg)
      redirect_to articles_path
    else
      render 'new'
    end

  end




  private
  def rating_params
    params.require(:rating).permit(:mark)
  end
end
