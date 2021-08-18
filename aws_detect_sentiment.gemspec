require_relative "lib/aws_detect_sentiment/version"

Gem::Specification.new do |spec|
  spec.name          = "aws_detect_sentiment"
  spec.version       = AwsDetectSentiment::VERSION
  spec.authors       = ["Aleksey Strizhak"]
  spec.email         = ["alexei.mifrill.strizhak@gmail.com"]

  spec.summary       = "Detect sentiment by Aws::Comprehend::Client"
  spec.description   = "Provided Client-object to detect the sentiment of provided word/words by Aws::Comprehend API"
  spec.homepage      = "https://github.com/Mifrill/aws_detect_sentiment.git"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/Mifrill/aws_detect_sentiment/blob/master/CHANGELOG.md"

  spec.require_paths = ["lib"]
  spec.files         = Dir["{lib}/**/*"] + %w[LICENSE.txt]

  spec.add_runtime_dependency "aws-sdk-comprehend", "1.48.0"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec", "~> 3.8"
end
