class Admin::PostsController < ApplicationController

  def index
    @post_all = Post.all
    @posts = Post.page(params[:page]).per(10)
    @user = current_user
    @tag_pre = Tag.where(tag_kind: 0)
    @tag_genre = Tag.where(tag_kind: 1)
    @tag_others = Tag.where(tag_kind: 2)
    
    # タグ検索機能
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_posts = Tag.find_by(name: key).posts
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
          @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
        end
      end
    end

    if params[:tag]
      Tag.create(name: params[:tag])
    end

  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to action: :index
    else
      render :show
    end
  end

end
