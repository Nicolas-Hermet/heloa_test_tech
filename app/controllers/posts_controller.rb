class PostsController < ApplicationController
  def index
    @query = params[:query].presence
    @pagy, @posts = @query ? pagy(Post.search_by_content_title_and_tags(@query), items: 10) : pagy(Post.all, items: 10)
  end

  def show
    @post = Post.find(params[:id])
  end
end
