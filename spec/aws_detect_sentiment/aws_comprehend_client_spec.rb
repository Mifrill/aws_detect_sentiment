describe AwsDetectSentiment::AwsComprehendClient do
  subject(:aws_comprehend_client) { described_class.new }

  describe "#detect_sentiments" do
    let(:texts) { ["some neutral text", "some positive text"] }
    let(:responses) do
      [
        {
          error_list: [],
          result_list: [
            {
              index: 0,
              sentiment: "NEUTRAL",
              sentiment_score: {
                mixed: 4.1197799873771146E-5,
                negative: 0.48717790842056274,
                neutral: 0.49973341822624207,
                positive: 0.013047484681010246
              }
            },
            {
              index: 1,
              sentiment: "POSITIVE",
              sentiment_score: {
                mixed: 3.3134326713479823E-6,
                negative: 0.05255420133471489,
                neutral: 0.24108187854290009,
                positive: 0.7063606381416321
              }
            }
          ]
        }
      ]
    end

    it { expect(aws_comprehend_client.detect_sentiments(texts, stub_responses: responses)).to eq(%w[neutral positive]) }
  end

  describe "#detect_sentiment" do
    let(:text) { "some positive text" }
    let(:response) do
      {
        sentiment: "POSITIVE",
        sentiment_score: {
          mixed: 3.6582869142876007E-6,
          negative: 0.0010295789688825607,
          neutral: 0.3397200405597687,
          positive: 0.6592467427253723
        }
      }
    end

    it { expect(aws_comprehend_client.detect_sentiment(text, stub_response: response)).to eq("positive") }
  end
end
