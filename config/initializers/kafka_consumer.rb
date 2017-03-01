require "kafka"

 $kafka = Kafka.new(seed_brokers: ["localhost:9092", "localhost:9092"],logger: Rails.logger,)


# # Consumers with the same group id will form a Consumer Group together.
consumer = $kafka.consumer(group_id: "my-consumer")

# # It's possible to subscribe to multiple topics by calling `subscribe`
# # repeatedly.
 consumer.subscribe("test")