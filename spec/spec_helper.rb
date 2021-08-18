require "aws_detect_sentiment"
require "byebug"
require_relative './support/matchers'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

AwsDetectSentiment.configure do |config|
  config.stub_client_requests = true
  config.aws_region = ENV.fetch("AWS_REGION", "region")
  config.aws_access_key_id = ENV.fetch("AWS_ACCESS_KEY_ID", "key")
  config.aws_secret_access_key = ENV.fetch("AWS_SECRET_ACCESS_KEY", "secret")
end
