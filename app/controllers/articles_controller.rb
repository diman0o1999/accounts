class ArticlesController < LoggedUserController

  before_action :set_resource, only: %i[show edit update destroy]

  def index
    # @articles = Article.all
    @articles = policy_scope(Article)

    if params[:q].present?
       @articles = @articles.where("articles.title ILIKE :q", q: "%#{params[:q]}%")
    end
    @articles = @articles.order('created_at DESC')
    @articles = @articles.page(params[:page])

    @list_ip = Article.all.group_by(&:ip)

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.ip = request.remote_ip
    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    authorize @article
  end

  def add_to_favorites
    @article = Article.find(params[:id])
    @favorite = @article.favorites.new(user: current_user)
    if @favorite.save
      respond_with @article
    else
      render json: { error: @favorite.errors.full_messages }
    end
  end


  def add_to_report
    @article = Article.find(params[:id])
    @favorite = @article.favorites.new(user: current_user)
    if @favorite.save
      respond_with @article
    else
      render json: { error: @favorite.errors.full_messages }
    end
  end

  def delete_from_favorites
    puts '=-=-==-==->>>>'
    puts 'delete_from_favorites'
    puts '=-=-==-==->>>>'
    puts 'params[:id]', params[:id]
    @article = Article.find(params[:id])
    puts '@article', @article.id
    @favorite = @article.favorites.find_by(user: current_user)
    if @favorite.destroy
      puts 'D E L E T E D'
      respond_with @article
    else
      puts 'N O T    D E L E T E D'
      render json: { error: @favorite.errors.full_messages }
    end
  end

  def edit
    authorize @article
  end





  def update
    authorize @article
    # с помощью Active Record нахожу статью по id, которые беру из параметров

    if @article.update!(article_params)

      # Делаю переход(переадресацию) на страницу /articles домашняя страница статей
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize @article
    @article.destroy
    respond_with do |format|
      format.json { render json: @article }
    end
  end

  private

  def set_resource
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(
        :title,
        :text,
        :image,
        articles_categories_attributes: [:id, :category_id, :_destroy]
    )
  end

end
