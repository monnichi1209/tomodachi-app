class PicturesController < ApplicationController

  # 一覧表示
  def index
    @pictures = Picture.all
  end

  # 新規作成フォーム
  def new
    @picture = Picture.new
  end

  # 新規作成
  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to @picture
    else
      render 'new'
    end
  end

  # 詳細表示
  def show
    @picture = Picture.find(params[:id])
  end

  # 編集フォーム
  def edit
    @picture = Picture.find(params[:id])
  end

  # 更新
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to @picture
    else
      render 'edit'
    end
  end

  # 削除
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path
  end

  private

  # ストロングパラメータ
  def picture_params
    params.require(:picture).permit(:title, :image)
  end

end
