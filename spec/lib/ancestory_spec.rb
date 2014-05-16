require './lib/ancestory.rb'

describe Ancestory do

  let(:ancestory) { described_class.new }

  describe '#in_ancestory?' do

    context 'when a key is given an ancestor' do
      before(:each) do
        ancestory.provide_ancestor(:foo, :type_thing)
      end

      context 'and that key is checked against itself' do
        subject { ancestory.in_ancestory?(:foo, :foo) }

        it { should be_true }
      end

      context 'and that key is checked against its ancestor' do
        subject { ancestory.in_ancestory?(:foo, :type_thing) }

        it { should be_true }
      end

      context 'and another child association is made' do
        before(:each) do
          ancestory.provide_ancestor(:bar, :foo)
        end

        context 'and that child is checked for the greatest ancestor' do
          subject { ancestory.in_ancestory?(:bar, :type_thing) }

          it { should be_true }
        end

        context 'and another key is checked for the greatest ancestor' do
          subject { ancestory.in_ancestory?(:blah, :type_thing) }

          it { should be_false }
        end

      end

    end

    context 'when no ancestory details have been given' do

      context 'and some ancestory is checked' do
        subject { ancestory.in_ancestory?(:foo, :bar) }

        it { should be_false }
      end

      context 'and thing is checked if it is in the registry of thing' do
        subject { ancestory.in_ancestory?(:type_thing, :type_thing) }

        it { should be_true }
      end

    end

  end

end
