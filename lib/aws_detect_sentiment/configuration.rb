require "ostruct"

module AwsDetectSentiment
  class << self
    def configuration
      @configuration ||= OpenStruct.new
    end

    def configure
      yield(configuration)
    end
  end
end
