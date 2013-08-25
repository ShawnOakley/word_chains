class WordChains

  attr_accessor :dictionary

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ').join(' ')
    p dictionary
  end

  def adjacent_words(word, dictionary)
    # Uses regex, via helper function find_adjacency, to check and return an array of 'adjacent' words (i.e., words with only one letter difference). The final select expression filters out the original word.
    dictionary.scan(/#{find_adjacency(word)}/).select{|word| word != word}
  end

  def find_adjacency(word)
    # Creates a single regular expression of the form \\b(?:\wxx|x\wx|xx\w)\\b where \\b signifies the border of the word and the x represented a word's given character, and \w represents any character.  The | operator denotes 'or', meaning any one of the expressions will satisfy the regex.
    adjacency_array = Array.new
    word.size.times do |index|
      regex = word.dup.split('')
      regex[index] = '\w'
      adjacency_array << regex.join('')
    end
    full_regex = '\b(?:' + adjacency_array.join('|') + ')\b'
  end


end

if __FILE__ == $0
  wchains = WordChains.new
  p wchains.adjacent_words('berry', wchains.dictionary)
end