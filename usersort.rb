#!/usr/bin/env ruby

module UserCompare
  def <=>(other)
    map = {'g'=>1, 'l'=>-1, "e"=>0}
    char = nil
    loop do
      char = prompt_user other
      break if map.key? char.downcase
    end
    map[char.downcase]
  end

  # TODO remember past comparisons
  # TODO use past comparisons to implement transitive property
  #   if a>b && b>c, then we know a>c, no need to ask user
  # TODO use past comparisions to throw exceptions if a paradoxical evaluation is entered
  #   if a>b && b>c, a must be > c (will implementing the transitive property remove the chance for a user to do this?)

  def prompt_user(other)
    puts "Comparing A: #{self.to_s}"
    puts "          B: #{other.to_s}"
    print "Press 'g' for A>B, 'l' for a<b, or 'e' for a==b: "
    char = ""
    loop do
      char = STDIN.getc
      break if char != "\n" #discard newline characters
    end
    char
  end
end

class TestObj
  prepend UserCompare
  def initialize(str)
    @str = str
  end
  def to_s
    @str
  end
end

if __FILE__==$0
  test = [
    "worst",
    "worse",
    "bad",
    "neutral",
    "good",
    "better",
    "best"
  ]

  objs = test.collect{ |str| TestObj.new str }

  sorted = objs.shuffle.sort
  puts sorted.collect(&:to_s).inspect
end
