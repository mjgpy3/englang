require './lib/parser/tok.rb'

class Parser

  # TODO: make tokenizer an instance
  def initialize(tokenize_method = ->(line){ Tok.enize(line) })
    @tokenize_method = tokenize_method
  end

  def given_line(line)
    @tokens = @tokenize_method.call(line)
    self
  end

  def first_name
    types_matching(String, //).first
  end

  def first_type
    types_matching(Symbol, /^type_/).first
  end

  def should_invert?
    @tokens.include?(:kwd_not)
  end

  def question?
    @tokens[0..1] == [:kwd_i, :kwd_ask]
  end

  def ancestory?
    @tokens.include?(:kwd_kind)
  end

  def assignment?
    @tokens.include?(:kwd_has)
  end

  def question_of_kind?
    @tokens.include?(:kwd_is)
  end

  def question_of_existence?
    @tokens.include?(:kwd_exist)
  end

  private

  def types_matching(klass, regex = //)
    @tokens.select { |tok| tok.is_a?(klass) && tok.to_s.match(regex) }
  end

end
