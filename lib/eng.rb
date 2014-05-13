require './lib/parser/tok.rb'

class Eng

  def self.run_line(line)
    Tok.enize(line).include?(:kwd_not) ? 'No' : 'Yes'
  end

end
