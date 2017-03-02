require "kafka"
require "active_support/notifications"
# Configure the Kafka client with the broker hosts and the Rails
# logger.
$kafka = Kafka.new(
  seed_brokers: ["localhost:9092", "localhost:9092"],
  logger: Rails.logger,
)

# Set up an asynchronous producer that delivers its buffered messages
# every ten seconds:
$kafka_producer = $kafka.async_producer(delivery_threshold: 5,
  delivery_interval: 10, max_retries: 5, retry_backoff: 5, required_acks: :all
)
$kafka_producer.deliver_messages


$kafka_consumer = $kafka.consumer(group_id: "my-consumer")
$kafka_consumer.subscribe("test")