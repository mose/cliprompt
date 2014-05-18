require_relative 'lib/cliprompt'

class Myclass
  include Cliprompt

  def initialize
    @url = ask "What is the url of Myclass?"
    @ssl = ask 'Is it using SSL?', 'y/N'
    @age = ask "What is the age of the captain?", ['22', '33', '=44', '55']
  end
end

Myclass.new
