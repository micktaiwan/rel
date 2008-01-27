#require '../MLib/TextPrompt'
require 'mrel'

HELP =<<END
Algebraic Relation Calculator
Try "A={(1,2)}" and "A"
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
        puts @rel.exec(c)
      end # case
    end # while
  end # start
  
end # class App

App.new.start
