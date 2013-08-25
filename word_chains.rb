require 'set'

class WordChains

  attr_accessor :dictionary, :already_visited

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ').join(' ')
    self.already_visited = []
  end

  def adjacent_words(word, dictionary)
    # Uses regex, via helper function find_adjacency, to check and return an array of 'adjacent' words (i.e., words with only one letter difference). The final select expression filters out the original word.
    dictionary.scan(/#{find_adjacency(word)}/).select { |sim_word| sim_word != word }
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

  def compare_with_previous(possible_targets)
    p possible_targets
    possible_targets = possible_targets.split(' ') - self.already_visited
    self.already_visited += possible_targets
    possible_targets
  end


  def find_chain(start_word, end_word, dictionary)
    if start_word == end_word
      return start_word
    else
      p adjacent_words(start_word, dictionary).compact
      possible_targets = compare_with_previous(find_adjacency(start_word))
      if possible_targets != nil
        possible_targets.each do |word|
          return start_word + "->" + find_chain(word, end_word, dictionary)
        end
      else
        return nil
      end
    end
  end

end

if __FILE__ == $0
  wchains = WordChains.new
#  p wchains.adjacent_words('cat', wchains.dictionary)
  p wchains.find_chain('cat', 'rat', wchains.dictionary)
end