module Cliprompt

  class OptionException < StandardError
  end

  class Optionset

    attr_reader :choices, :default, :boolean, :envdefault

    def initialize(options)
      if options == []
        @choices = []
        @default = nil
        @boolean = false
        @envdefault = nil
      else
        meth = "parse_#{options.class.name.downcase}".to_sym
        if respond_to? meth
          send(meth, options)
        else
          fail OptionException, "Undefined parser ::#{meth}"
        end
      end
    end

    def parse_hash(args)
      @choices = args[:choices] || args['choices']
      if args[:default] == false || args['default'] == false
        @default = false
      else
        @default = args[:default] || args['default']
      end
      @boolean = args[:yesno] || args['yesno']
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

    def boolean?
      @boolean
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

  end
end
