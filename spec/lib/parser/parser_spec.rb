require './lib/parser/parser.rb'

describe Parser do

  let(:parser) { described_class.new }

  describe '#first_name' do

    context 'when a string containing names is given' do
      subject { parser.given_line('it is test "name" blah').first_name }

      it { should == 'name' }
    end

  end

  describe '#first_type' do
    context 'when a string containing types is given' do
      subject { parser.given_line('"foobar" is im_a_type test "name" blah').first_type }

      it { should == :type_im_a_type }
    end

  end

  describe '#should_invert?' do

    {
      '"foobar" is im_a_type not test "name" blah' => true,
      '"foobar" is im_a_type test "name" blah' => false
    }.each do |line, bool|
      context "when given '#{line}'" do
        subject { parser.given_line(line).should_invert? }

        it { should be(bool) }
      end

    end

  end

  describe '#question?' do

    {
      'I ask ...' => true,
      'I do ask ...' => false
    }.each do |line, bool|
      context 'when a string beginning with "I ask" is given' do
        subject { parser.given_line(line).question? }

        it { should be(bool) }
      end

    end

  end

  describe '#ancestory?' do

    {
      'blah blah kind blah blah' => true,
      'blah blah' => false
    }.each do |line, bool|
      context "when given #{line}" do
        subject { parser.given_line(line).ancestory? }

        it { should be(bool) }
      end

    end

  end

  describe '#assignment?' do

    {
      'blah blah has blah blah' => true,
      'blah blah' => false
    }.each do |line, bool|
      context "when given #{line}" do
        subject { parser.given_line(line).assignment? }

        it { should be(bool) }
      end

    end

  end

  describe '#question_of_kind?' do

    {
      'blah blah is blah blah' => true,
      'blah blah' => false
    }.each do |line, bool|
      context "when given #{line}" do
        subject { parser.given_line(line).question_of_kind? }

        it { should be(bool) }
      end

    end

  end

  describe '#question_of_existence?' do

    {
      'blah blah exist blah blah' => true,
      'blah blah' => false
    }.each do |line, bool|
      context "when given #{line}" do
        subject { parser.given_line(line).question_of_existence? }

        it { should be(bool) }
      end

    end

  end

end
