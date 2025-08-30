class PhotosController < ApplicationController
  before_action :require_login

  def index
    @photos = current_user.photos.order(created_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      redirect_to photos_path, notice: "写真がアップロードされました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def tweet
    photo = current_user.photos.find(params[:id])
    access_token = session[:access_token]
    if access_token.blank?
      redirect_to photos_path, alert: "アクセストークンがありません"
      return
    end

    require "net/http"
    require "uri"
    require "json"

    uri = URI.parse("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    req = Net::HTTP::Post.new(uri.path, {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{access_token}"
    })
    req.body = {
      text: photo.title,
      url: url_for(photo.image)
    }.to_json

    res = http.request(req)
    if res.code == "201"
      redirect_to photos_path, notice: "ツイートしました"
    else
      redirect_to photos_path, alert: "ツイートに失敗しました"
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end

  def require_login
    redirect_to new_session_path, alert: "ログインしてください" unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
