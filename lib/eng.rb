require './lib/parser/parser.rb'
require './lib/ancestory.rb'

class Eng

  def initialize(ancestory = Ancestory.new, parser = Parser.new)
    @ancestory = ancestory
    @parser = parser
    @my_values = {}
  end

  def run_line(line)
    tokenize(line)

    store_value if @parser.assignment?
    set_ancestor if @parser.ancestory?
    answer if @parser.question?
  end

  private

  # TODO: Refactor logic for answering questions to Answerer class

  def store_value
    @my_values[@parser.first_name] = @parser.first_type
  end

  def set_ancestor
    @ancestory.provide_ancestor(@parser.first_type, :type_thing)
  end

  def answer
    determine_question_type
    make_answer
  end

  def determine_question_type
    @question = :exist? if @parser.question_of_existence?
    @question = :exist_with_type? if @parser.question_of_kind?
  end

  def make_answer
    b_to_s(@parser.should_invert? ? !send(@question) : send(@question))
  end

  def exist?
    @my_values.include?(@parser.first_name)
  end

  def exist_with_type?
    return false if !exist?
    @ancestory.in_ancestory?(@my_values[@parser.first_name], @parser.first_type)
  end

  def tokenize(line)
    @parser.given_line(line)
  end

  def b_to_s(b_value)
    b_value ? 'Yes' : 'No'
  end
end
