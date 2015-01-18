
class NewsController < ApplicationController

  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :check_admin

  respond_to :html

  def check_admin
    redirect_to '/' and return if (!(user_signed_in? and current_user.admin) )
  end

  def index
    @news = News.all
    respond_with(@news)
  end

  def show
    respond_with(@news)
  end

  def new
    redirect_to '/' and return if (!user_signed_in? and !current_user.admin)
    @news = News.new
    @news.user_id=current_user.id
    respond_with(@news)
  end

  def edit
  end

  def create
    @news = News.new(news_params)
    @news.user_id=current_user.id
    @news.save
    respond_with(@news)
  end

  def update
    @news.update(news_params)
    respond_with(@news)
  end

  def destroy
    @news.destroy
    respond_with(@news)
  end

  private
    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit(:id, :body, :user_id, :show,:title)
    end
end
