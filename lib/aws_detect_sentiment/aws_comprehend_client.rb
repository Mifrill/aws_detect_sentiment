require "aws-sdk-comprehend"

module AwsDetectSentiment
  class AwsComprehendClient
    BATCH_LIMIT = 25

    def initialize
      self.s3_client =
        Aws::Comprehend::Client.new(
          stub_responses: stub_enabled?,
          region: AwsDetectSentiment.configuration.aws_region,
          access_key_id: AwsDetectSentiment.configuration.aws_access_key_id,
          secret_access_key: AwsDetectSentiment.configuration.aws_secret_access_key
        )
    end

    def detect_sentiment(text, options: inner_options, stub_response: {})
      s3_client.stub_responses(:detect_sentiment, stub_response) if stub_enabled?
      sentiment(s3_client.detect_sentiment(text: text, **options))
    end

    def detect_sentiments(texts, batch_limit: BATCH_LIMIT, options: inner_options, stub_responses: [{}])
      texts.each_slice(batch_limit).map.with_index do |texts_slice, index|
        s3_client.stub_responses(:batch_detect_sentiment, stub_responses[index]) if stub_enabled?
        s3_client.batch_detect_sentiment(text_list: texts_slice, **options).result_list
      end.flatten.map(&method(:sentiment))
    end

    private

    attr_accessor :s3_client

    def sentiment(result)
      result.sentiment.downcase
    end

    def inner_options
      {
        language_code: "en"
      }
    end

    def stub_enabled?
      AwsDetectSentiment.configuration.stub_client_requests
    end
  end
end
