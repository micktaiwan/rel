require 'rubygems'
require 'treetop'
require 'common'

class MRel
  
  def initialize
    Treetop.load "rel"
    @parser = RelParser.new
    @symbols = {}
    #puts @parser.root
  end
  
  # return [command,result]
  # ex: ['affectation',['A',<Relation>]]
  def exec(text)
    @node = @parser.parse(text)
    return (['error',@parser.failure_reason] or ['error',"Syntax error"]) if !@node
    return ['error',"No action for #{@node.text_value}"] if !@node.respond_to?('action')
    
    return send(@node.action)
  end
  
  # flatten relations
  def exec_flat(text)
    rv = exec(text)
    rv[1]= rv[1].map {|e| e.respond_to?('value') ? e.value : e.to_s}
    rv
  end
  
  protected
  
  def a_symbol
    ['symbol',[@node.text_value,@symbols[@node.text_value]]]
  end
  
  def a_affectation
    s   = @node.elements[0].text_value
    rel = @node.elements[4].value
    @symbols[s] = rel
    ['affectation',[s,rel]]
  end
  
  def a_calcul
    ['calcul',@node.value]
  end
  
  def a_commands # FIXME: too complicated.....
    bak = @node
    rv = nil
    bak.elements.each {|n| 
      @node = n
      #puts "COMMANDS: #{n.text_value}"
      rv = send(n.action) if n.respond_to?('action')
    }
    rv
  end
  
  def a_list_symbols
    ['list_symbols',@symbols]  
  end
  
  def inspect
    if @node.terminal?
      puts 'terminal ' + @node.text_value
    else
      @node.elements.each { |el|
        puts "=== Element"
        puts el.inspect
      }
    end
  end
  
end
