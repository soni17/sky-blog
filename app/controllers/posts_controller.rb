class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy add_comment ]
  before_action :require_login, except: %i[ index show ]
  skip_before_action :verify_authenticity_token, :only => [:add_comment]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_url(@post), notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  def add_comment
    @post.comments << Comment.create(post: @post, body: params[:comment], user_id: 1)
    @comments = @post.comments
    render partial: "comment"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
