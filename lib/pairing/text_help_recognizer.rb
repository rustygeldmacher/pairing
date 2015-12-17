class TextHelpRecognizer
    BP_HELP = 'To enter blood pressure, text \'bp ###/##\''
    FG_HELP = 'To enter fasting glucose, text \'fgc ###\''
    WEIGHT_HELP = 'To enter weight, text \'wt to ###.#\''
    LONG_FORM_HELP = "For help with blood pressure, text 'help bp', for help with weight, type 'help weight', for help with fasting glucose, type 'help fgc'"

    attr_accessor :help_text

    def initialize(message)
        command = /^help\s+(bp|fgc|wt)$/.match(message)
        if command
            subcommand = command[1]

            if subcommand == "bp"
                @help_text = BP_HELP
            elsif subcommand == "fgc"
                @help_text = FG_HELP
            elsif subcommand == "wt"
                @help_text = WEIGHT_HELP
            end
        else
            @help_text = LONG_FORM_HELP
        end
    end
end
