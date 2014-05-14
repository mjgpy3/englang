require './lib/parser/tok.rb'

class Eng

  def initialize
    @my_values = []
  end

  def run_line(line)
    tokens = Tok.enize(line)

    @my_values << tokens[-1] if tokens.include?(:kwd_has)

    if tokens[0..1] == [:kwd_i, :kwd_ask]
      @my_values.include?(tokens[-3]) ? 'Yes' : 'No'
    end
  end

end
