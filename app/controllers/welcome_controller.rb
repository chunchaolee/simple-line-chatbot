class WelcomeController < ApplicationController
  protect_from_forgery with: :null_session
  def webhook
    head 200
  end
end
