require_relative "aws_detect_sentiment/version"
require_relative "aws_detect_sentiment/configuration"
require_relative "aws_detect_sentiment/aws_comprehend_client"
require_relative "aws_detect_sentiment/assign"

module AwsDetectSentiment
  class Error < StandardError; end
end
