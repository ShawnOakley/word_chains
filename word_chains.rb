dictionary = File.readlines('dictionary.txt').join(" ")

def find_adjacency (word)
  adjacency_array = []
  #word = word.split('')
  (0...word.length).to_a.each do |char_index|
    temp = word.dup
    temp[char_index] = '\w'
    adjacency_array << temp#.join('')
  end
  adjacency_array = '\b(?:' + adjacency_array.join('|') + ')\b'
end


def adjacent_words(word, dictionary)

  adjacency_list = find_adjacency(word)
  adjacent_word = dictionary.scan(/#{adjacency_list}/)

end

def find_chain(start_word, end_word, dictionary)
  current_words = [start_word]
  visited_words = [start_word]
  chain_hash = { start_word => nil}

  new_words = current_words.map do |word|
    adjacent_words(word, dictionary)
  end

  new_words = new_words.flatten - visited_words

  #p new_words

  until new_words.include?(end_word)
  temp_words = new_words

    current_words.each do |word|
      individual_return = adjacent_words(word, dictionary).flatten
      if word.is_a?(String)
        (individual_return.uniq - visited_words).each do |found_word|
          chain_hash[found_word] = word if word != found_word
        end
      end
      new_words << individual_return.uniq - visited_words
    end


    current_words = temp_words
    (visited_words << current_words).flatten
    new_words = new_words.flatten.uniq - visited_words

  end
  chain_hash
end

def build_chain(visited_words, word)

  if visited_words[word] == nil
    return word
  else
    return word + " - " + build_chain(visited_words, visited_words[word])
    #return visited_words[word].to_s + " - " + build_chain(visited_words, visited_words[word])
    p "entered loop"
  end

  #visited_words

end


# puts adjacent_words('zoo', dictionary)
p build_chain(find_chain('fume', 'lame', dictionary), "lame")


