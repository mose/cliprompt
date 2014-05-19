require_relative 'lib/cliprompt'

class Myclass
  include Cliprompt

  def initialize
  end

  def askit
    puts '-------------------'
    puts 'Free form'
    show "This simply ask for a simple form mandatory thing?"
    show "This simply ask for a simple form mandatory thing?", 'with a default'
    show "This simply ask for a simple form mandatory thing?", default: 'with a default again'
    puts '-------------------'
    puts 'yes/no'
    show 'a boolean?', 'y/N'
    show 'a boolean?', 'yN'
    show 'a boolean?', 'yesno'
    show 'a boolean?', 'yesNo'
    show 'a boolean?', boolean: true
    show 'a boolean?', boolean: true, default: false
    puts '-------------------'
    puts 'a list of choices'
    show 'a list without default?', ['22', '33', '44', '55']
    show 'a list without default?', choices: ['22', '33', '44', '55'], default: '22'
    show 'a list with default?', ['22', '33', '=44', '55']
    show 'a list with default?', choices: ['22', '33', '=44', '55']
  end

  def show(*args)
    it = ask *args
    puts "-- returned #{it.inspect}"
    puts
  end
end

m = Myclass.new
m.askit
