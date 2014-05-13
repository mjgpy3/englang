require './lib/parser/tok.rb'

describe Tok do

  describe '.enize' do

    subject { described_class.enize(text) }

    [
      ['', []],
      ['I', [:kwd_i]],
      ['ask', [:kwd_ask]],
      ['thing', [:kwd_thing]],
      ['is', [:kwd_is]]
    ].each do |text, tokens|
      context "when given the '#{text}' keyword" do
        let(:text) { text }

        it { should == tokens }
      end
    end

    [
      'a'
    ].each do |word|
      context "when given a fluff word: '#{word}'" do
        let(:text) { word }

        it { should == [] }
      end
    end

    context 'when given an identifier "foo"' do
      let(:text) { 'foo' }

      it { should == [[:ident, 'foo']] }
    end

    [
      ['.', [:dot]],
      ['?', [:quest]],
      [':', [:colon]]
    ].each do |mark, tokens|
      context "when given the '#{mark}' punctuation mark" do
        let(:text) { mark }

        it { should == tokens }
      end
    end

    context 'when given multiple tokens' do
      let(:text) { 'I ask' }

      it { should == [:kwd_i, :kwd_ask] }
    end

    context 'when given a word ending in punctuation' do
      let(:text) { 'beers?' }

      it { should == [[:ident, 'beers'], :quest] }
    end

  end

end
