# encoding: utf-8

require 'spec_helper'
require 'cliprompt'

describe Cliprompt do

  describe '.ask' do

    context 'when I debug,' do
      let(:input) { StringIO.new }
      let(:output) { StringIO.new }
      before { subject.setio(input, output) }
      it {
        expect(output).to receive(:puts).with('what')
        expect(subject.ask('what', choices: ['na','woot','xx'], default: 'woot', env: 'WOOT')).not_to raise_error
      }
    end

    context 'when there are preset choices,' do
      it 'is displayed ay the end of the question' do
      end
    end
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
