require './lib/eng.rb'

describe Eng do

  describe '.run_line' do
    
    context 'when given a reflective axiom' do 
      subject { described_class.run_line("I ask: is a thing a thing?") }

      it { should match(/Yes/) }
    end

    context 'when given the anit-reflective axiom' do
      subject { described_class.run_line("I ask: is a thing not a thing?") }

      it { should match(/No/) }
    end

  end

end
