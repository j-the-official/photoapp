class SessionsController < ApplicationController
  def new
    redirect_to photos_path if logged_in?
  end

  def create
    errors = []
    errors << "ユーザーIDを入力してください" if params[:user_id].blank?
    errors << "パスワードを入力してください" if params[:password].blank?

    if errors.any?
      flash.now[:alert] = errors.join("<br>")
      return render :new, status: :unprocessable_entity
    end

    if params[:user_id] == params[:password]
      flash.now[:alert] = "ユーザーIDとパスワードが⼀致するユーザーが存在しない"
      return render :new, status: :unprocessable_entity
    end

    user = User.find_by(user_id: params[:user_id])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "ユーザーID、もしくはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "ログアウトしました"
  end
end
