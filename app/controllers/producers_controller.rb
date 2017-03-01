class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :update, :destroy]
  #send and receive notifications

  ActiveSupport::Notifications.subscribe(/.*\.kafka$/) do |*args|
  $event = ActiveSupport::Notifications::Event.new(*args)
  puts "Received notification `#{$event.name}` with payload: #{$event.payload.inspect}"
  #call check_message method
  check_message
  end

  def send_message
      #save message param to message variable
      $user_message = params[:message]
      #create message, and save it in the database
      message = save_message
      #Create @event
      @event = {
        message_id: message.id,
        message: $user_message,
        timestamp: Time.now,
        
      }
      #send @event
      $kafka_producer.produce(@event.to_json, topic: "test")
      #render :ok
      render json: "Message sent successfully"

      
  end

  def save_message 
    message = Message.new(message: $user_message)
    message.transaction do
    message.save!
    return message
    end      
  end

  def self.check_message
    if ($event.name.starts_with?("ack_message.producer.kafka"))
      payload = $event.payload
      value_hash = JSON.parse(payload[:value])
      message_id = value_hash["message_id"]
      message = Message.find_by_id(message_id)
      message.destroy!
    end
  end
end