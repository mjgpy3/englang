require './lib/eng.rb'

describe Eng do

  let(:eng) { described_class.new }

  describe '#run_line' do

    context 'when no assignment is given' do

      context 'and I check if that assigned value exists' do
        subject { eng.run_line('I ask: does "foobar" exist?') }

        it { should match(/No/) }
      end

    end

    context 'when given an assignment' do
      before(:each) do
        eng.run_line('I have a thing named "foobar"')
      end

      context 'and I check if that assigned value exists' do
        subject { eng.run_line('I ask: does "foobar" exist?') }

        it { should match(/Yes/) }
      end

    end

  end

end
