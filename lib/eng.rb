require './lib/parser/tok.rb'

class Eng

  def initialize
    @my_values = []
  end

  def run_line(line)
    tokenize(line)

    store_value if an_assignment?
    answer if a_question?
  end

  private

  def store_value
    @my_values << first_name
  end

  def an_assignment?
    @tokens.include?(:kwd_has)
  end

  def answer
    b_to_s(should_invert? ? !value_exist? : value_exist?) 
  end

  def value_exist?
    @my_values.include?(first_name)
  end

  def should_invert?
    @tokens.include?(:kwd_not)
  end

  def a_question?
    @tokens[0..1] == [:kwd_i, :kwd_ask]
  end

  def first_name
    @tokens.select { |x| x.is_a?(String) }.first
  end

  def tokenize(line)
    @tokens = Tok.enize(line)
  end

  def b_to_s(b_value)
    b_value ? 'Yes' : 'No'
  end
end
