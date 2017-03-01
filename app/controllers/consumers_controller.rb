class ConsumersController < ApplicationController
  before_action :set_consumer, only: [:show, :update, :destroy]
  
# This method is to load messages from kafka
  def load_message


      $message_array = []
      $kafka_consumer.each_message(min_bytes: 5000, max_wait_time: 2) do |message|
  
      temp = [*$message_array.each_with_index].bsearch{|x, _| x.value["timestamp"] > message.value["timestamp"]}
      if (temp.nil?)
        index = 0
      else
        index = temp.last
      end
      $message_array.insert(index, message)

      end
  
  end


#This method is for rendering messages from kafka. 
def next_message

  if $message_array.last.nil?
    render json: "Queue is empty"
  else
  render json: $message_array.pop
   end
end
end