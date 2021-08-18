require "ostruct"

describe AwsDetectSentiment::Assign do
  subject(:detect_sentiments_service) do
    described_class.new(scope: scope, text_field: text_field)
  end

  let(:sentiments) { %w[positive mixed neutral negative] }
  let(:text_field) { :text }
  let(:scope) { [] }

  describe "#perform" do
    let(:positive_answer) { OpenStruct.new(text: "text") }
    let(:mixed_answer) { OpenStruct.new(text: "text") }
    let(:neutral_answer) { OpenStruct.new(text: "text") }
    let(:negative_answer) { OpenStruct.new(text: "text") }
    let(:texts) { scope.map(&:text) }
    let(:perform) do
      lambda do
        detect_sentiments_service.perform do |record, sentiment|
          record.sentiment = sentiment
        end
      end
    end

    context "with AwsComprehendClient" do
      let(:api_client) { AwsDetectSentiment::AwsComprehendClient }
      let(:aws_comprehend_client) { instance_double(api_client) }
      let(:scope) { [positive_answer, mixed_answer, neutral_answer, negative_answer] }

      it "updates question_answers with sentiments and sentiment_detected_at" do
        expect(api_client).to receive(:new).and_return aws_comprehend_client
        expect(aws_comprehend_client).to receive(:detect_sentiments).with(
          texts
        ).and_return sentiments
        expect { perform.call }.to avoid_exception
        {
          positive_answer => "positive",
          mixed_answer => "mixed",
          neutral_answer => "neutral",
          negative_answer => "negative"
        }.each do |answer, sentiment|
          expect(answer.sentiment).to eq sentiment
        end
      end
    end

    context "with any api_client" do
      subject(:detect_sentiments_service) do
        described_class.new(scope: scope, text_field: text_field, api_client: any_api_client)
      end

      let(:api_client) { Class.new { def detect_sentiments(*); end } }
      let(:any_api_client) { instance_double(api_client) }

      context "when answer_text is blank" do
        let(:scope) { [answer_with_empty_text, answer_without_text] }
        let(:answer_with_empty_text) { OpenStruct.new(text: "") }
        let(:answer_without_text) { OpenStruct.new(text: nil) }

        it "does not updates with no exceptions" do
          expect(any_api_client).not_to receive(:detect_sentiments)
          expect { perform.call }.to avoid_exception
        end
      end

      context "when no question_answers" do
        let(:scope) { [] }

        it "does not raise exception" do
          expect(any_api_client).not_to receive(:detect_sentiments)
          expect { perform.call }.to avoid_exception
        end
      end
    end
  end
end
