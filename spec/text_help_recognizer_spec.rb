require 'spec_helper'

describe 'TextHelpRecognizer' do
    it "should set help_text to long form help when passed gibberish" do
        message = "ssasasads"
        recognizer = TextHelpRecognizer.new(message)

        expect(recognizer.help_text).to eq(TextHelpRecognizer::LONG_FORM_HELP)
    end

    it "should set help_text to blood pressure help when passed 'help bp'" do
        message = "help bp"
        recognizer = TextHelpRecognizer.new(message)

        expect(recognizer.help_text).to eq(TextHelpRecognizer::BP_HELP)
    end

    it "should set help_text to fasting glucose help when passed 'help fgc'" do
        message = "help fgc"
        recognizer = TextHelpRecognizer.new(message)

        expect(recognizer.help_text).to eq(TextHelpRecognizer::FG_HELP)
    end

    it "should set help_text to weight help when passed 'help wt'" do
        message = "help wt"
        recognizer = TextHelpRecognizer.new(message)

        expect(recognizer.help_text).to eq(TextHelpRecognizer::WEIGHT_HELP)
    end

    it "should require a space between 'help' arguments" do
        message = "helpybp"
        recognizer = TextHelpRecognizer.new(message)

        expect(recognizer.help_text).to eq(TextHelpRecognizer::LONG_FORM_HELP)
    end

    it "should not recognize erronious characters after the subcommand" do
        message = "help wtttttttt"
        recognizer = TextHelpRecognizer.new(message)

        expect(recognizer.help_text).to eq(TextHelpRecognizer::LONG_FORM_HELP)
    end
end
