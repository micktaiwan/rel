class Relation
  
  def initialize(arr=[])
    @value = arr
  end
  
  def to_s
    if @value == []
      '{}'
    else
      "{%s}" % @value.map {|couple| "(#{couple[0]},#{couple[1]})"}.join(', ')
    end
  end
end
