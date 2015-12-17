```ruby
module Api
  module Measurements::V1
    class TextMeasurementsController < ApiController
      skip_before_filter :authorize_api

      def create
        patient        = FindPatientFromText.new(message.from)
        tokenized_text = TextBodyTokenizer.new(message.body)
        measurement    = MeasurementFromTextFactory.from_text(tokenized_text, patient)
        status         = measurement.save

        send_response_text(status.response)

        render nothing: true
      rescue
        if patient.patient
          text = <<-TXT.gsub(/^ {8}/, '')
          Sorry! I didn't recognize that. You can submit fasting glucose like this:
          fgc 50
          Or weight like this:
          wt 180.2
          TXT
          send_response_text(text)
        end
        render nothing: true
      end

      private

      def send_response_text(body)
        @response_text ||= TwilioMessage.create(
          from: from_number,
          to: message.from,
          body: body)
      end

      def from_number
        TwilioConfiguration.number(:measurements)
      end

      def message
        @message ||= TwilioMessage.get(params['MessageSid'])
      end
    end
  end
end
```

```
help
  For help with blood pressure, text 'help bp', for help with weight, type 'help weight', for help with fasting glucose, type 'help fgc'

help bp
  To enter <blood pressure>, text '<bp> ###/##'

help fgc
  To enter <fasting glucose>, text '<fgc> ###'

help wt
  To enter <weight>, text '<wt> ###.#'

help <gibberish>
  Long form help text from above

<gibberish>
  Long form help text from above
```
