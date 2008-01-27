#require '../MLib/TextPrompt'
require 'mrel'

HELP =<<END
Algebraic Relation Calculator
q:   quit
Symbols begin with capital letters, and then downcase (A, Test, Myrelation)
Affection:
  A={(1,2)}
Display a symbol value
  A
END

class App #< TextPrompt
  
  def initialize
    @rel = MRel.new    
  end
  
  def start
    puts 'Rel 0.0.1 (This is really still just a test)'
    puts '"h" helps'
    while true
      print '>'
      c = gets.chomp
      case c
        when 'q'
        break 
        when 'h'
        puts HELP
        when ''
      else
        d(@rel.exec(c))
      end # case
    end # while
  end # start
  
  def d(arr)
    result = arr[1] 
    case arr[0]
      when 'error'
      puts "Error: #{result}"
      when 'symbol'
      puts 'Symbol not found' and return if result[1] == nil
      puts result[1].to_s
      when 'affectation'
      puts result[1].to_s
    else
      puts "Unknown return: #{arr[0]}"
    end
  end
  
end # class App

App.new.start
