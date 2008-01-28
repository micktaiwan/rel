require 'test/unit'
require 'treetop'
require 'mrel'

class TC_REL < Test::Unit::TestCase
  
  def setup
    Treetop.load "rel"
    @parser = RelParser.new
    @rel = MRel.new
  end
  
  # def teardown
  # end
  
  def test_syntax
    assert(@parser.parse('A'))
    assert(!@parser.parse('a'))
    assert(@parser.parse('Abc'))
    assert(@parser.parse('A={}'))
    assert(@parser.parse('A = { }'))
    assert(@parser.parse('Rel={(1,2)}'))
    assert(@parser.parse('A={(1,2),(1,2)}'))
    assert(!@parser.parse('A={(1,2),}'))
    assert(!@parser.parse('A={(1,)}'))
    assert(!@parser.parse('A={(,1)}'))

    assert(@parser.parse('A=B'))
    assert(@parser.parse('A+B'))
    assert(@parser.parse('{}+{}'))
    assert(@parser.parse('A=B+C'))
    
    assert(@parser.parse('A;A'))
    
    assert_equal([],@parser.parse('{}').value)
    #assert_equal([],@parser.parse('{};{}').value)
    #assert_equal([],@parser.parse('A={};A').value)
    assert_equal([[1,2]],@parser.parse('{(1,2)}').value)
    assert_equal([[1,2]],@parser.parse('{(1,2),(1,2)}').value)
    assert_equal([[1,2],[2,3]],@parser.parse('{(1,2),(2,3)}').value)
  end
  
  def test_affect
    assert_equal(['symbol',['A',nil]],@rel.exec('A'))
    assert_equal(['symbol',['A',[]]],@rel.exec_flat('A={};A'))
    assert_equal(['symbol',['A',[[1,2]]]],@rel.exec_flat('A={(1,2)};A'))
    assert_not_equal(['symbol',['A',nil]],@rel.exec('A'))
    #assert_equal([[1,2]],@parser.parse('A={(1,2)}').elements[0].value)
    #assert_equal([[1,2],[2,3]],@parser.parse('A={(1,2),(2,3)}').elements[0].value)
  end
  
end
