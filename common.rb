# considers a Array as a relation
class Array
  def to_s
    case self
      when []
      '{}'
      when nil
      'nil'
    else
      return "{#{self.map {|couple| !couple ? 'nil':"(#{couple[0]},#{couple[1]})"}.join(', ')}}" 
    end
  end
end
