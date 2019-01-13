require 'line/bot'
class WelcomeController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_line_client, :reply_token, only: [:webhook]
  def webhook
    @client.reply_message(@reply_token, message(params["events"].first["message"]["text"]))

    head 200
  end

  private

  def message(arg)
    case arg.to_s.downcase.squish
    when 'help'
      {
        type: 'text',
        text: '功能有: (1) ChatBot Owner、(2) Company、(3) Job、(4) Team、(5) Contact'
      }
    when 'chatbot owner'
      {
        type: 'text',
        text: 'Owner: Nathan Lee ; Github: https://github.com/chunchaolee/simple-line-chatbot/tree/master'
      }
    when 'company'
      {
        type: 'text',
        text: '果實夥伴 (OneAD) ; https://www.onead.com.tw/'
      }
    when 'job'
      {
        type: 'text',
        text: 'Current Job: Software Engineer (BackEnd) ; Resume: https://www.cakeresume.com/nathan-lee'
      }
    when 'team'
      {
        type: 'text',
        text: 'Manager: Leon, FrontEnd: Leo, BackEnd: Nathan'
      }
    when 'contact'
      {
        type: 'text',
        text: 'Email: chunchaolee@gmail.com / Cell: +886 987-430-525 / Facebook: https://www.facebook.com/nathen.lee'
      }
    else
      {
        type: 'text',
        text: '尚未支援該功能哦，歡迎透過 Email 反饋 Bug 或建議，謝謝 ^^'
      }
    end
  end

  def set_line_client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def reply_token
    @reply_token = params['events'][0]['replyToken']
  end
end
