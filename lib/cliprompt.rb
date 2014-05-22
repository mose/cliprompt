require "paint"

require "cliprompt/version"
require "cliprompt/optionset"

module Cliprompt

  module_function

  MSG_MANDATORY_TEXT = "Sorry you need to fill that information."
  MSG_YES_OR_NO = "You need to answer by yes, no, y, n, 1 or 0."
  MSG_CHOSE_IN_LIST = "You need to chose between the available options."
  MSG_CHOSE_A_NUMBER = "Choose a number:"

  def ask(question, *options)
    if options[0].class == Optionset
      opts = options[0]
    else
      opts = Optionset.new *options
    end
    if opts.biglist?
      output.puts "#{question}"
      opts.choices.each_with_index do |choice, i|
        if opts.default == choice
          output.printf "> %-3s %s\n", i, choice
        else
          output.printf "  %-3s %s\n", i, choice
        end
      end
      output.print "#{MSG_CHOSE_A_NUMBER} "
    else
      output.print "#{question} #{opts.display} "
    end
    answer = input.gets.chomp
    output.flush
    opts.validate(question, answer)
  end

  def guess(env, question, *options)
    opts = Optionset.new *options
    if ENV[env]
      opts.validate(question, ENV[env])
    else
      ask question, opts
    end
  end

  def say(message)
    output.puts message
  end

  def shout(message)
    output.puts Paint[message, :bold, :red ]
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
