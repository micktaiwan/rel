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
    
    assert_equal([],@parser.parse('{}').value)
    assert_equal([[1,2]],@parser.parse('{(1,2)}').value)
    assert_equal([[1,2]],@parser.parse('{(1,2),(1,2)}').value)
    assert_equal([[1,2],[2,3]],@parser.parse('{(1,2),(2,3)}').value)
  end
  
  def test_affect
    assert_equal(['symbol',nil],@rel.exec('A'))
    assert_equal(['symbol',[]],@rel.exec('A={};A'))
    assert_equal(['symbol',[[1,2]]],@rel.exec('A={(1,2)};A'))
    assert_not_equal(['symbol',nil],@rel.exec('A'))
    assert_equal(['symbol',[]],@rel.exec('A={};B=A;B'))
    #assert_equal([[1,2]],@parser.parse('A={(1,2)}').elements[0].value)
    #assert_equal([[1,2],[2,3]],@parser.parse('A={(1,2),(2,3)}').elements[0].value)
  end
  
end
