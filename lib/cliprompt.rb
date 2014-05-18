require "dye"

require "cliprompt/version"
require "cliprompt/optionset"

module Cliprompt

  module_function

  CUSTOM_STYLES = {
    error: [ :bold, :red ],
    ok:    [ :bold, :green ]
  }
  define_dye_method CUSTOM_STYLES

  MSG_MANDATORY_TEXT = Dye.dye("Sorry you need to fill that information.", [ :bold, :red ])
  MSG_YES_OR_NO = Dye.dye("You need to answer by yes, no, y or n.", [ :bold, :red ])
  MSG_CHOSE_IN_LIST = Dye.dye("You need to chose between the available options.", [ :bold, :red ])

  def ask(question, *options)
    if options[0].class == Optionset
      opts = options[0]
    else
      opts = Optionset.new *options
    end
    output.print "#{question} #{opts.display} "
    answer = input.gets.chomp
    output.flush
    check(answer, question, opts)
  end

  def check(answer, question, opts)
    if answer == ''
      if !opts.default.nil?
        answer = opts.default
      else
        output.puts MSG_MANDATORY_TEXT
        ask(question, opts)
      end
    else
      if opts.boolean
        if /^(y(es)?|n(o)?)$/.match(answer.downcase)
          answer = !/^y(es)?$/.match(answer.downcase).nil?
        else
          output.puts MSG_YES_OR_NO
          ask(question, opts)
        end
      elsif opts.choices.count > 0 && !opts.choices.include?(answer)
        output.puts MSG_CHOSE_IN_LIST
        ask(question, opts)
      else
        answer
      end
    end
  end

  def setio(input, output)
    @@input = input
    @@output = output
  end

  def input
    @@input ||= STDIN
  end

  def output
    @@output ||= STDOUT
  end

end
