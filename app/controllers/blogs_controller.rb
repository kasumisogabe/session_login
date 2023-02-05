class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)
    # if params[:back]
    #   render :new
    # else
    if @blog.save
      redirect_to blogs_path, notice: 'ブログを投稿しました'
    else
      render :new
    end
    # end
  end

  def show
    set_blog
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    set_blog
    @blog = Blog.find(params[:id])
  end

  def update
    set_blog
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: '投稿を編集しました'
    else
      render :edit
    end
  end

  def destroy
    set_blog
    @blog.destroy
    redirect_to blogs_path, notice: '投稿を削除しました'
  end

  # def confirm
  #   @blog = Blog.new(blog_params)
  #   render :new if @post.invalid?
  # end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
