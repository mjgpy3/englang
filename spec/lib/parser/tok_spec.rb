require './lib/parser/tok.rb'

describe Tok do

  describe '.enize' do

    subject { described_class.enize(text) }

    [
      ['', []],
      ['I', [:kwd_i]],
      ['ask', [:kwd_ask]],
      ['thing', [:kwd_thing]],
      ['is', [:kwd_is]],
      ['not', [:kwd_not]],
      ['named', [:kwd_named]],
      ['called', [:kwd_named]],
      ['have', [:kwd_has]],
      ['has', [:kwd_has]],
      ['exist', [:kwd_exist]],
      ['does', [:kwd_does]]
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

    [
      ['foo', 'foo'],
      ['"foo"', 'foo']
    ].each do |ident, ident_value|
      context "when given an identifier #{ident}" do
        let(:text) { ident }

        it { should == [ident_value] }
      end
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

      it { should == ['beers', :quest] }
    end

    context 'when given a line of text' do
      let(:text) { "I ask: is a thing a thing?" }

      it { should == [:kwd_i, :kwd_ask, :colon, :kwd_is, :kwd_thing, :kwd_thing, :quest] }
    end

  end

end
