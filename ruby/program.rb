
class String
  def sentences
    gsub(/\n|\r/, ' ').split(/\.\s*/)
  end
end
class String
  def words
    scan(/\w[\w\'\-]*/)
  end
end
class WordPlay
  def self.best_sentence(sentences, desired_words)
    ranked_sentences = sentences.sort_by do |s|
      s.words.length - (s.downcase.words - desired_words).length
    end
    ranked_sentences.last
  end
def self.switch_pronouns(text)
  text.gsub(/\b(I am|You are|I|You|Your|My)\b/i) do |pronoun|
    case pronoun.downcase
      when "i"
        "you"
      when "you"
        "I"
      when "i am"
        "you are"
      when "you are"
        "i am"
      when "your"
        "my"
      when "my"
        "your"
    end
  end
end
end
if ARGV.empty?
  puts "Please provide Ruby code as a command-line argument."
else
  # Access the first command-line argument using ARGV[0]
  ruby_code = ARGV[0]

  begin
    # Evaluate the provided Ruby code using eval
    result = eval(ruby_code)
    puts "Result: #{result.inspect}"
  rescue Exception => e
    puts "Error executing code: #{e.message}"
  end
end
