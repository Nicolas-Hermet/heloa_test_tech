class PostsController < ApplicationController
  def index
    @query = params[:query].presence
    @posts = @query ? Post.search_by_content_title_and_tags(@query) : Post.all.first(10)
  end
end
