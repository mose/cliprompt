# encoding: utf-8

require 'spec_helper'
require 'cliprompt'

describe Cliprompt do

  describe '.ask' do
    Given(:input) { StringIO.new }
    Given(:output) { StringIO.new }
    Given { subject.setio(input, output) }

    # context 'when it is free form,' do
    #   When(:question) { 'wazza?' }
    #   context 'without default,' do
    #     When(:args) { }
    #     When { subject.input.stub(:gets).and_return("\n") }
    #     When { subject.ask(question, args) }
    #     Then { expect(output).to receive(:print).with("#{question}  ") }
    #     context 'when enter key is used,' do
    #       When(:answer) { subject.ask(question) }
    #       When { input.gets("\n") }
    #       Then { expect(output).to receive(:puts).with(Cliprompt::MSG_MANDATORY_TEXT)}
    #     end
    #   end
    #   it 'is displayed ay the end of the question' do
    #   end
    # end
    context 'when there is no preset choices,' do
      it 'only displays the question' do
      end
    end
    context 'when enter is typed,' do
      it 'returns the default value' do
      end
    end
    context 'when a value is provided' do
      it 'returns the value' do
      end
    end

  end

end
