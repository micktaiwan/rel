require 'rubygems'
require 'treetop'
require 'common'

@@symbols = Hash.new(nil)

def get_symbol(s)
  @@symbols[s]
end

def set_symbol(s,v)
  @@symbols[s] = v
end


class MRel
  
  def initialize
    Treetop.load "rel"
    @parser = RelParser.new
    #puts @parser.root
  end
  
  # return the command result text
  def exec(text)
    @node = @parser.parse(text)
    return (['error',@parser.failure_reason] or ['error',"Syntax error"]) if !@node
    return ['error',"No action for #{@node.text_value}"] if !@node.respond_to?('action')
    
    return send(@node.action)
  end
  
  # flatten relations
  #def exec_flat(text)
#    rv = exec(text)
#    rv[1]= rv[1].map {|e| e.respond_to?('value') ? e.value : e.to_s} if rv[1]
#    rv
#  end

  protected
  
  def a_symbol
    ['symbol',[@node.text_value,@@symbols[@node.text_value]]]
  end
  
  def a_affectation
    s   = @node.elements[0].text_value
    rel = Relation.new(@node.elements[4].value)
    @@symbols[s] = rel
    ['affectation',[s,rel]]
  end
  
  def a_calcul
    v = @node.value
    if v == nil # symbol ?
      v = @@symbols[@node.text_value]
      return ['symbol',v]
    end
    ['calcul',v]
  end
  
  def a_list_symbols
    ['list_symbols',@@symbols]  
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
