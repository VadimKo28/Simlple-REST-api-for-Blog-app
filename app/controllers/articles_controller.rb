class ArticlesController < ApplicationController
  def index
    articles = User.find(params[:user_id]).articles.select(:id, :title, :body)
    render json: { status: :ok, message: "Articles load", data: articles }
  end

  def create
    article = User.find(params[:user_id]).articles.new(articles_params)
    if article.save
      render json: { status: 201, message: "Article saved", data: article }
    else
      render json: { errors: article.errors,message: "Article saved", status: :unprocessable_entity}
    end
  end

  def show
    article = find_article(params[:id])
    render json: { message: "Article load", data: article, status: :ok}
  end

  def update
    article = Article.find(params[:id])
    if article.update(articles_params)
      article = find_article(params[:id])
      render json: { message: "Article updated", data: article, status: :ok}
    else
      render json: { errors: article.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    render json: { message: "Article destroy", data: article, status: 204}
  end

  private

  def articles_params
    params.require(:article).permit(:title, :body)
  end

  def find_article(id)
    Article.select(:id, :title, :body).where(id: id)
  end
end
