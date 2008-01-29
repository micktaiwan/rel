#require '../MLib/TextPrompt'
require 'mrel'

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
        help
        when ''
      else
        d(@rel.exec(c))
      end # case
    end # while
  end # start
  
  def help
    if system('uname')
      system('cat help.txt | more')
    else
      system('type help.txt | more')
    end
  end
  
  
  # display results
  def d(arr)
    result = arr[1] 
    case arr[0]
      when 'error'
      puts "Error: #{result}"
      when 'symbol'
      if result[1] == nil
        puts 'Symbol not found'
        return
      end
      puts result[1].to_s
      when 'affectation'
      puts "#{result[0]}=#{result[1].to_s}"
      when 'calcul'
      puts result.to_s
      when 'list_symbols'
      result.each {|s,rel| puts "#{s}: #{rel.to_s}"}
    else
      puts "Unknown return: #{arr[0]}"
    end
  end
  
end # class App

App.new.start
