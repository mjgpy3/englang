class Tok

  KWDS = {
    'I' => :kwd_i,
    'ask' => :kwd_ask,
    'thing' => :kwd_thing,
    'is' => :kwd_is,
    'not' => :kwd_not,
    'named' => :kwd_named,
    'called' => :kwd_named,
    'have' => :kwd_has,
    'has' => :kwd_has,
    'exist' => :kwd_exist,
    'does' => :kwd_does
  }

  FLUFF = [
    'a', ''
  ]

  PUNCT = {
    '.' => :dot,
    ':' => :colon,
    '?' => :quest
  }

  NON_IGNORE = KWDS.merge(PUNCT)

  def self.enize(text)
    val = []
    text.split(' ').each do |word|
      if NON_IGNORE[word]
        val << NON_IGNORE[word]
      elsif PUNCT[word[-1]]
        val += enize(word[0..-2]) + enize(word[-1])
      elsif word.start_with?('"') && word.end_with?('"')
        val << word[1..-2]
      elsif !FLUFF.include?(word)
        val << word
      end
    end
    val
  end

end
