# encoding: utf-8

require 'spec_helper'
require 'cliprompt'
require 'cliprompt/optionset'

describe Cliprompt do
  Given(:input) { StringIO.new }
  Given(:output) { StringIO.new }
  Given { subject.setio(input, output) }

  describe '.ask' do
    Given(:question) { 'wazza?' }
    Given(:answer) { 'xxx' }
    context 'without default,' do
      When(:args) { }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.ask(question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question}  " }
    end
    context 'with a default,' do
      When(:default) { 'ooo' }
      When(:args) { { default: default } }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.ask(question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question} [#{default}] " }
    end
    context 'with an optionset,' do
      When(:args) { Cliprompt::Optionset.new() }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.ask(question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question}  " }
    end
  end

  describe '.say' do
    Given(:msg) { "hah" }
    When { subject.say msg }
    Then { expect(output.string).to eq "#{msg}\n" }
  end

  describe '.shout' do
    Given(:msg) { "hah" }
    When { subject.shout msg }
    Then { expect(output.string).to eq "#{Paint[msg, :bold, :red ]}\n" }
  end

end
