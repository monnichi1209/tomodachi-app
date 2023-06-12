class FeedsController < ApplicationController
  skip_before_action :login_required, only: [:index, :show]
  before_action :set_feed, only: %i[ show edit update destroy ]

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    if session[:feed]
      @feed = Feed.new(session[:feed])
      session.delete(:feed)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    session[:feed] = @feed.attributes
    if @feed.valid?
      render :confirm
    else
      render :new
    end
  end
  
  

  def edit
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    if params[:back]
      @feed.attributes = session[:feed] 
      render :new
    else
      if @feed.save
        session.delete(:feed)
        redirect_to feeds_path, notice: "Feed was successfully created."
      else
        render :new
      end
    end
  end
  

  def update
    respond_to do |format|
      if @feed.save
        format.html { redirect_to feed_url(@feed), notice: "Feed was successfully created." }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to feed_url(@feed), notice: "Feed was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "画像の削除が確認されました." }
      format.json { head :no_content }
    end
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.fetch(:feed, {}).permit(:image, :image_cache, :content)
    end
  end