require "cliprompt/version"
require "cliprompt/optionset"

module Cliprompt

  module_function

  def ask(question, *options)
    output.puts question
    opts = Optionset.new options
    # output.print "#{question} "
    # output.print "[#{choices.join('/')}] " if choices
    # back = input.gets.chomp
    # back = default if back == ''
    # output.flush
    # back
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
