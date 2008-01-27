require 'test/unit'
require 'treetop'

class TC_MyTest < Test::Unit::TestCase
  def setup
    Treetop.load "rel"
    @parser = RelParser.new
  end
  
  # def teardown
  # end
  
  def test_syntax
    assert(@parser.parse('A'))
    assert(!@parser.parse('a'))
    assert(@parser.parse('Abc'))
    assert_equal([],@parser.parse('A={}').elements[5].value)
    assert(@parser.parse('A = { }'))
    assert(@parser.parse('Rel={(1,2)}'))
    assert(@parser.parse('A={(1,2),(1,2)}'))
    assert(!@parser.parse('A={(1,2),}'))
  end
end
