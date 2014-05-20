module Cliprompt

  class OptionException < StandardError
  end

  class Optionset

    attr_reader :choices, :default, :boolean, :envdefault

    def initialize(options = nil)
      @choices = []
      @default = nil
      @boolean = false
      @envdefault = nil
      @type = options.class.name.downcase
      meth = "parse_#{@type}".to_sym
      if respond_to? meth
        send(meth, options)
      else
        fail OptionException, "Undefined parser ::#{meth}"
      end
    end

    def parse_nilclass(args)
    end

    def parse_hash(args)
      @choices = args[:choices] || args['choices'] || []
      parse_array @choices
      if args[:default] == false || args['default'] == false
        @default ||= false
      else
        @default ||= args[:default] || args['default']
      end
      @boolean = args[:boolean] || args['boolean']
      @default = true if (@boolean && @default.nil?)
      @envdefault = args[:env] || args['env']
    end

    def parse_array(args)
      @choices = args.map do |a|
        if a[0] && a[0] == '='
          @default = a[1..-1]
        else
          a
        end
      end
    end

    def parse_string(arg)
      if arg.downcase.match /^y(es)?(\/)?n(o)?/
        @boolean = true
        if /y(es)?(\/)?N/.match arg
          @default = false
        else
          @default = true
        end
      else
        @default = arg
      end
    end

    def display
      back = ''
      if @boolean
        back = @default ? "[Y/n]" : "[y/N]"
      else
        if @choices.count > 0
          back += "(#{@choices.join(' / ')})"
        end
        back += "[#{@default}]" if @default
      end
      return back
    end

    def validate(question, answer)
      if answer == ''
        check_default question
      elsif @boolean
        check_boolean question, answer
      elsif @choices.count > 0
        check_choices question, answer
      else
        answer
      end
    end

    def check_default(question)
      return ask_again(question, Cliprompt::MSG_MANDATORY_TEXT) if @default.nil?
      @default
    end

    def check_boolean(question, answer)
      answer.downcase!
      return ask_again(question, Cliprompt::MSG_YES_OR_NO) unless /^(y(es)?|n(o)?)$/.match(answer)
      !/^y(es)?$/.match(answer).nil?
    end

    def check_choices(question, answer)
      return ask_again(question, Cliprompt::MSG_CHOSE_IN_LIST) unless @choices.include?(answer)
      answer
    end

    def ask_again(question, msg)
      Cliprompt.shout msg
      Cliprompt.ask question, self
    end

  end
end
