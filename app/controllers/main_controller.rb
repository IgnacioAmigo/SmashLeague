class MainController < ApplicationController
  before_action :authenticate_user!, :except => [:faq]
  def index
  	@users = User.all
  	@news = News.last(10)
  end

  def faq
  end
end
