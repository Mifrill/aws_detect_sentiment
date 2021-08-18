# AwsDetectSentiment

Provided Client-object to detect the sentiment of provided word or array of words by Aws::Comprehend API

- https://aws.amazon.com/getting-started/hands-on/analyze-sentiment-comprehend/
- https://github.com/aws/aws-sdk-ruby/tree/version-3/gems/aws-sdk-comprehend

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aws_detect_sentiment'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install aws_detect_sentiment

## Usage

```ruby
AwsDetectSentiment.configure do |config|
  config.aws_region = ENV["AWS_REGION"]
  config.aws_access_key_id = ENV["AWS_ACCESS_KEY_ID"]
  config.aws_secret_access_key = ENV.fetch["AWS_SECRET_ACCESS_KEY"]
end
```

```ruby
AwsDetectSentiment::AwsComprehendClient.new.detect_sentiment('positive test')
# => positive
AwsDetectSentiment::AwsComprehendClient.new.detect_sentiments(['positive test', 'negative text'], batch_limit: 5)
# => ['positive', 'negative']
```

Rails usage example to assign sentiments:
```ruby
# QuestionAnswer - ActiveRecord model
# without_sentiment - scope like: where(sentiment_detected_at: nil)
# :answer - name of instance method (column) of ActiveRecord model: Question.first.answer
Question.without_sentiment.in_batches do |batch|
  AwsDetectSentiment::Assign.new(scope: batch.to_a, text_field: :answer).perform
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Mifrill/aws_detect_sentiment. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Mifrill/aws_detect_sentiment/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AwsDetectSentiment project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Mifrill/aws_detect_sentiment/blob/master/CODE_OF_CONDUCT.md).
