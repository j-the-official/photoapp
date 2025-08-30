class OauthController < ApplicationController
  require "net/http"
  require "uri"
  require "json"

  def callback
    code = params[:code]
    if code.blank?
      redirect_to photos_path, alert: "認可コードがありません"
      return
    end

    uri = URI.parse("http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token")
    res = Net::HTTP.post_form(uri, {
      code: code,
      client_id: "v7BfrCSBJB_IwUAYBLtqsEMnEo0UctHatPjdeQqmkxQ",
      client_secret: "8bzocsopEe6wjO4rlKru-A64csU_URoTypI58l_32Js",
      redirect_uri: "http://localhost:3000/oauth/callback",
      grant_type: "authorization_code"
    })

    body = JSON.parse(res.body) rescue {}
    access_token = body["access_token"]

    if access_token.present?
      session[:access_token] = access_token
      redirect_to photos_path, notice: "OAuth連携が完了しました"
    else
      redirect_to photos_path, alert: "アクセストークン取得に失敗しました"
    end
  end
end
