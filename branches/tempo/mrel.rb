require 'treetop'
require 'common'

class MRel
  
  def initialize
    Treetop.load "rel"
    @parser = RelParser.new
    @symbols = {}
    #puts @parser.root
  end
  
  # return the command result text
  def exec(text)
    @node = @parser.parse(text)
    return (['error',@parser.failure_reason] or ['error',"Syntax error"]) if !@node
    return ['error',"No action for #{@node.text_value}"] if !@node.respond_to?('action')
    
    return send(@node.action)
  end
  
  protected
  
  def a_symbol
    ['symbol',[@node.text_value,@symbols[@node.text_value]]]
  end
  
  def a_affectation
    s   = @node.elements[0].text_value
    rel = Relation.new(@node.elements[4].value)
    @symbols[s] = rel
    ['affectation',[s,rel]]
  end
  
  def a_calcul
    ['calcul',@node.value]  
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
