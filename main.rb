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
    puts 'Rel V0.1 - "h" helps'
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
  
  # display results
  def d(arr)
    result = arr[1] 
    case arr[0]
      when 'error'
      puts "Error: #{result}"
      when 'symbol'
      if result == nil
        puts 'Symbol not found'
        return
      end
      puts result.to_s
      when 'affectation'
      puts result[1].to_s
      when 'list_symbols'
      result.each {|s,rel| puts "#{s}: #{rel.to_s}"}
    else
      puts "Unknown return: #{arr[0]}"
    end
  end
  
end # class App

App.new.start
