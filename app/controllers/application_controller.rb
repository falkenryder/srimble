class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # def default_url_options
  #   { host: ENV["DOMAIN"] || "localhost:3000" }
  # end

  # heroku config:set DOMAIN=www.srimble.me
  # You can check it's properly set with heroku config:get DOMAIN.
end
