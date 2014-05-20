# encoding: utf-8

require 'spec_helper'
require 'cliprompt'
require 'cliprompt/optionset'

describe Cliprompt::Optionset do

  describe '.parse_array' do
    Given(:options) { ['xxx', 'yyy', 'zzz'] }

    context "when there is no default (#{['xxx', 'yyy', 'zzz'].to_s})," do
      Given(:set) { Cliprompt::Optionset.new(options) }
      When(:choices) { set.choices }
      When(:default) { set.default }
      When(:display) { set.display }
      Then { expect(choices).to eq options }
      Then { expect(default).to be_false }
      Then { expect(display).to eq '(xxx / yyy / zzz)' }
    end

    context "when there is a default specified (#{['xxx', '=yyy', 'zzz'].to_s})," do
      Given(:options_with_default) { ['xxx', '=yyy', 'zzz'] }
      Given(:set) { Cliprompt::Optionset.new(options_with_default) }
      When(:choices) { set.choices }
      When(:default) { set.default }
      When(:display) { set.display }
      Then { expect(choices).to eq options }
      Then { expect(default).to eq 'yyy' }
      Then { expect(display).to eq '(xxx / yyy / zzz)[yyy]' }
    end
  end

  describe '.parse_hash' do

    context 'when there is choices and default,' do
      context "when using sym keys (#{{ default: 'xxx', choices: ['xxx', 'yyy', 'zzz'] }.to_s})," do
        Given(:options) { { default: 'xxx', choices: ['xxx', 'yyy', 'zzz'] } }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:choices) { set.choices }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(choices).to eq ['xxx', 'yyy', 'zzz'] }
        Then { expect(default).to eq 'xxx' }
        Then { expect(display).to eq '(xxx / yyy / zzz)[xxx]' }
      end
      context "when using string keys (#{{ 'default' => 'xxx', 'choices' => ['xxx', 'yyy', 'zzz'] }.to_s})," do
        Given(:options) { { 'default' => 'xxx', 'choices' => ['xxx', 'yyy', 'zzz'] } }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:choices) { set.choices }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(choices).to eq ['xxx', 'yyy', 'zzz'] }
        Then { expect(default).to eq 'xxx' }
        Then { expect(display).to eq '(xxx / yyy / zzz)[xxx]' }
      end
    end

    context 'when there is only boolean,' do
      context 'when  no default is given, default booean is Y,' do
        Given(:options) { { boolean: true } }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        When(:boolean) { set.boolean }
        Then { expect(default).to be_true }
        Then { expect(boolean).to be_true }
        Then { expect(display).to eq '[Y/n]' }
      end
      context 'when default is given as true, default booean is Y,' do
        Given(:options) { { boolean: true, default: true } }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        When(:boolean) { set.boolean }
        Then { expect(default).to be_true }
        Then { expect(boolean).to be_true }
        Then { expect(display).to eq '[Y/n]' }
      end
       context 'when default is given as false, default boolean is N,' do
        Given(:options) { { boolean: true, default: false } }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        When(:boolean) { set.boolean }
        Then { expect(default).to be_false }
        Then { expect(boolean).to be_true }
        Then { expect(display).to eq '[y/N]' }
      end
   end
  end

  describe '.parse_string' do

    context 'when a "yesno" kind of string is passed,' do
      context 'when using yesno,' do
        Given(:options) { 'yesno' }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        When(:boolean) { set.boolean }
        Then { expect(default).to be_true }
        Then { expect(boolean).to be_true }
        Then { expect(display).to eq '[Y/n]' }
      end
      context 'when using yn,' do
        Given(:options) { 'yn' }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(default).to be_true }
        Then { expect(display).to eq '[Y/n]' }
      end
      context 'when using YN,' do
        Given(:options) { 'YN' }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(default).to be_true }
        Then { expect(display).to eq '[Y/n]' }
      end
      context 'when using yesNo,' do
        Given(:options) { 'yesNo' }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(default).to be_false }
        Then { expect(display).to eq '[y/N]' }
      end
      context 'when using yN,' do
        Given(:options) { 'yesNo' }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(default).to be_false }
        Then { expect(display).to eq '[y/N]' }
      end
      context 'when using y/N,' do
        Given(:options) { 'yesNo' }
        Given(:set) { Cliprompt::Optionset.new(options) }
        When(:default) { set.default }
        When(:display) { set.display }
        Then { expect(default).to be_false }
        Then { expect(display).to eq '[y/N]' }
      end
    end

  end

  describe '.validate' do
    Given(:question) { 'so what?' }
    context 'when enter key is hit,' do
      Given(:input) { '' }
      Given(:set) { Cliprompt::Optionset.new() }
      When { set.stub(:check_default).with(question) }
      Then { expect(set).to receive(:check_default).with(question) }
      And  { expect{ set.validate(question, input) }.not_to raise_error }
    end
    context 'when it is a boolean,' do
      Given(:input) { 'x' }
      Given(:set) { Cliprompt::Optionset.new(boolean: true) }
      When { set.stub(:check_boolean).with(question, input) }
      Then { expect(set).to receive(:check_boolean).with(question, input) }
      And  { expect{ set.validate(question, input) }.not_to raise_error }
    end
    context 'when it is a choice list,' do
      Given(:input) { 'x' }
      Given(:set) { Cliprompt::Optionset.new(choices: [1,2,3]) }
      When { set.stub(:check_choices).with(question, input) }
      Then { expect(set).to receive(:check_choices).with(question, input) }
      And  { expect{ set.validate(question, input) }.not_to raise_error }
    end
  end

  describe '.check_default' do
    Given(:question) { 'so what?' }
    Given(:msg) { Cliprompt::MSG_MANDATORY_TEXT }
    context 'when there is no default set,' do
      Given(:set) { Cliprompt::Optionset.new() }
      When { set.stub(:ask_again).with(question, msg) }
      Then { expect(set).to receive(:ask_again).with(question, msg) }
      And  { expect{ set.check_default(question) }.not_to raise_error }
     end
    context 'when there is a default set,' do
      Given(:default) { 'x' }
      Given(:set) { Cliprompt::Optionset.new(default: default) }
      When(:response) { set.check_default(question) }
      Then { expect(response).to eq default }
     end
  end


end
