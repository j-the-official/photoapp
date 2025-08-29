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
            redirect_to photos_path, notice: "Photo uploaded successfully."
        else
            render :new
        end
    end

    private

    def photo_params
        params.require(:photo).permit(:image, :description)
    end

    def require_login
        unless current_user
            redirect_to new_session_path, alert: "You must be logged in to access this section"
        end
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
