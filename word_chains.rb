require 'set'

class WordChains

  attr_accessor :dictionary, :visited_words, :chain_hash

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ').join(' ')
    self.visited_words = []
    self.chain_hash = {}
  end

  def adjacent_words(word, dictionary)
    # Uses regex, via helper function find_adjacency, to check and return an array of 'adjacent' words (i.e., words with only one letter difference). The final select expression filters out the original word.
    dictionary.scan(/#{find_adjacency(word)}/).select { |sim_word| sim_word != word }.uniq
  end

  def find_adjacency(word)
    # Creates a single regular expression of the form \\b(?:\wxx|x\wx|xx\w)\\b where \\b signifies the border of the word and the x represented a word's given character, and \w represents any character.  The | operator denotes 'or', meaning any one of the expressions will satisfy the regex.
    adjacency_array = Array.new
    word.size.times do |index|
      regex = word.dup.split('')
      regex[index] = '\w'
      adjacency_array << regex.join('')
    end
    full_regex = '\b' + adjacency_array.join('|') + '\b'
  end

  def compare_with_previous(possible_targets)
    # Compares with all previous targets to see if the word has already been introduced into the chain
    possible_targets = possible_targets - self.visited_words
    self.visited_words += possible_targets
    possible_targets
  end

  def update_hash(target, origin)
    if chain_hash[target] == nil
      chain_hash[target] = origin
    end
  end


  # Work on a recursive version of find_chain

  # def find_chain(start_word, end_word, dictionary)
  #   if start_word != end_word
  #     possible_targets = compare_with_previous(adjacent_words(start_word, dictionary))
  #       possible_targets.each do |word|
  #       start_word + "->" + find_chain(word, end_word, dictionary).to_s
  #     end
  #   else
  #     start_word
  #   end
  # end

  # Non-recursive version of find_chain

  def find_chain(start_word, end_word, dictionary)
    current_words = [start_word]
    visited_words = [start_word]
    chain_hash = { start_word => nil}

    possible_targets = current_words.map do |word|
      adjacent_words(word, dictionary)
    end

    possible_targets = compare_with_previous(possible_targets)

    until possible_targets.include?(end_word)

    end
  end

end

if __FILE__ == $0
  wchains = WordChains.new
  p wchains.find_chain('rat','cat', wchains.dictionary)
#  p wchains.adjacent_words('cat', wchains.dictionary)
#  p wchains.adjacent_words('rat', wchains.dictionary).count
#  wchains.already_visited = ['lat','kat']
#  p wchains.compare_with_previous(wchains.adjacent_words('rat', wchains.dictionary)).count
end