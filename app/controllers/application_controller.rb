class ApplicationController < ActionController::Base

  def index
    @article = [1..404]
  end
end
