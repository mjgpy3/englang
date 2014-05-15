require './lib/parser/tok.rb'

class Eng

  def initialize
    @my_values = []
  end

  def run_line(line)
    tokens = Tok.enize(line)

    @my_values << tokens[-1] if tokens.include?(:kwd_has)

    if tokens[0..1] == [:kwd_i, :kwd_ask]
      names = tokens.select { |x| x.is_a?(String) }
      name = names.first
      b_value = @my_values.include?(name)
      b_value = !b_value if tokens.include?(:kwd_not)
      b_to_s(b_value)
    end
  end

  private

  def b_to_s(b_value)
    b_value ? 'Yes' : 'No'
  end

end
