class Array
  def to_s
    if self == []
      '{}'
    else
      "{%s}" % self.map {|couple| "(#{couple[0]},#{couple[1]})"}.join(', ')
    end
  end
end
