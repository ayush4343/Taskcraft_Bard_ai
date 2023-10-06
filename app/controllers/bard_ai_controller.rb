  # app/controllers/bard_ai_controller.rb
class BardAiController < ApplicationController
  require 'httparty'
  require 'json'
  
  skip_before_action :verify_authenticity_token

  def process_text
    api_key = Rails.application.credentials.bard_ai_api_key
    api_url = "https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=#{api_key}" # Replace with Bard AI API endpoint

    response = HTTParty.post(
      api_url,
      headers: {
        'Content-Type' => 'application/json'
      },
      body: { "prompt": { "text": params[:message]} }.to_json
    )

    if response.code == 200
    
    begin
      result = JSON.parse(response.body)
      new_result = result["candidates"][0]["output"]

      # Process the JSON data here
      render json: new_result
    rescue JSON::ParserError => e
      # Handle JSON parsing error
      render json: { error: "Error parsin

        g JSON response: #{e.message}" }, status: :unprocessable_entity
    end
    else
    # Handle non-200 status code (e.g., API error)
    render json: { error: "API error: #{response.code} - #{response.body}" }, status: :unprocessable_entity
    end

  end

end
