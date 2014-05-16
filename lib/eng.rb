require './lib/parser/tok.rb'
require './lib/ancestory.rb'

class Eng

  def initialize(ancestory = Ancestory.new)
    @ancestory = ancestory
    @my_values = {}
  end

  def run_line(line)
    tokenize(line)

    store_value if an_assignment?
    set_ancestor if an_ancestory?
    answer if a_question?
  end

  private

  # TODO: Refactor logic for answering questions to Answerer class
  # TODO: Refactor logic for parsing tokens to a Parser class

  def store_value
    @my_values[first_name] = first_type
  end

  def set_ancestor
    @ancestory.provide_ancestor(first_type, :type_thing)
  end

  def an_assignment?
    @tokens.include?(:kwd_has)
  end

  def an_ancestory?
    @tokens.include?(:kwd_kind)
  end

  def answer
    determine_question_type
    make_answer
  end

  def determine_question_type
    @question = :exist? if question_of_existence?
    @question = :exist_with_type? if question_of_kind?
  end

  def question_of_kind?
    @tokens.include?(:kwd_is)
  end

  def question_of_existence?
    @tokens.include?(:kwd_exist)
  end

  def make_answer
    b_to_s(should_invert? ? !send(@question) : send(@question))
  end

  def exist?
    @my_values.include?(first_name)
  end

  def exist_with_type?
    return false if !exist?
    @ancestory.in_ancestory?(@my_values[first_name], first_type)
  end

  def should_invert?
    @tokens.include?(:kwd_not)
  end

  def a_question?
    @tokens[0..1] == [:kwd_i, :kwd_ask]
  end

  def first_name
    types_matching(String, //).first
  end

  def first_type
    types_matching(Symbol, /^type_/).first
  end

  def types_matching(klass, regex = //)
    @tokens.select { |tok| tok.is_a?(klass) && tok.to_s.match(regex) }
  end

  def tokenize(line)
    @tokens = Tok.enize(line)
  end

  def b_to_s(b_value)
    b_value ? 'Yes' : 'No'
  end
end
