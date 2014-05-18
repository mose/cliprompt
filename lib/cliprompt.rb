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

  def ask(question, *options)
    if options.class == Optionset
      opts = options
    else
      opts = Optionset.new options
    end
    output.print "#{question} #{opts.display} "
    answer = input.gets.chomp
    output.flush
    check(answer, question, opts)
  end

  def check(answer, question, opts)
    if answer == ''
      if opts.default
        answer = opts.default
      else
        output.puts dye("Sorry you need to fill that information.", :error)
        ask(question, opts)
      end
    else
      answer
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
