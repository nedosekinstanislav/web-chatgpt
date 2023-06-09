require 'httparty'

class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show update destroy ]

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      question_text = params[:question]
      answer_text = send_question_to_chatgpt(question_text)
      @chat.update(answer: answer_text)
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def send_question_to_chatgpt(question_text)
      api_key = Rails.application.secrets.openai_api_key
      api_url = 'https://api.openai.com/v1/chat/completions'
  
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
  
      payload = {
        'model' => 'gpt-3.5-turbo',
        'messages' => [
          {
            'role' => 'user',
            'content' => question_text
          }
        ]
      }
  
      response = HTTParty.post(api_url, headers: headers, body: payload.to_json)
      answer_text = response.parsed_response['choices'][0]['message']['content']
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:id, :question, :answer)
    end
end
