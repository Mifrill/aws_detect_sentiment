module AwsDetectSentiment
  class Assign
    # @param scope [Array<::Object>]
    # @param text_field [Symbol]
    # @param api_client [Object]
    def initialize(scope:, text_field:, api_client: AwsDetectSentiment::AwsComprehendClient.new)
      self.scope = scope
      self.text_field = text_field
      self.api_client = api_client
    end

    def perform
      records.each_with_index do |record, index|
        yield(record, sentiments[index])
      end
    end

    private

    def records
      scope.reject { |record| record.public_send(text_field).to_s.empty? }
    end

    attr_accessor :scope, :text_field, :api_client

    def sentiments
      @sentiments ||= api_client.detect_sentiments(texts)
    end

    def texts
      scope.map { |record| record.public_send(text_field) }
    end
  end
end
