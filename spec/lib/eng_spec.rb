require './lib/eng.rb'

describe Eng do

  let(:eng) { described_class.new }

  describe '#run_line' do

    context 'when I have not named a thing' do

      [
        ['exists', 'I ask: does "foobar" exist?', /No/],
        ['does not exist', 'I ask: does "foobar" not exist?', /Yes/],
        ['is a thing', 'I ask: is "foobar" a thing?', /No/],
        ['is a monkey', 'I ask: is "foobar" a monkey?', /No/]
      ].each do |check_text, line_to_run, expected_matcher|

        context "and I check if that non-existent thing #{check_text}" do
          subject { eng.run_line(line_to_run) }

          it { should match(expected_matcher) }
        end

      end

    end

    context 'when I name a thing' do
      before(:each) do
        eng.run_line('I have a thing named "foobar"')
      end

      [
        ['exists', 'I ask: does "foobar" exist?', /Yes/],
        ['exists using weird case', 'i aSk: DOES "fOobAr" eXist?', /Yes/],
        ['does not exist', 'I ask: does "foobar" not exist?', /No/],
        ['is a thing', 'I ask: is "foobar" a thing?', /Yes/],
        ['is a monkey', 'I ask: is "foobar" a monkey?', /No/],
        ['is not a monkey', 'I ask: is "foobar" not a monkey?', /Yes/]
      ].each do |check_text, line_to_run, expected_matcher|

        context "and I check if that named thing #{check_text}" do
          subject { eng.run_line(line_to_run) }

          it { should match(expected_matcher) }
        end

      end

    end

  end

end
