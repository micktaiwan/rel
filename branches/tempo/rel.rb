module Rel
  include Treetop::Runtime

  def root
    @root || :command
  end

  def _nt_command
    start_index = index
    if node_cache[:command].has_key?(index)
      cached = node_cache[:command][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_affectation
    if r1
      r0 = r1
    else
      r2 = _nt_calcul
      if r2
        r0 = r2
      else
        r3 = _nt_couple
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:command][start_index] = r0

    return r0
  end

  module Affectation0
    def symbol
      elements[0]
    end

    def s
      elements[1]
    end

    def s
      elements[3]
    end

    def set
      elements[4]
    end
  end

  module Affectation1
  			def action
  				'a_affectation'
  			end
  end

  def _nt_affectation
    start_index = index
    if node_cache[:affectation].has_key?(index)
      cached = node_cache[:affectation][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_symbol
    s0 << r1
    if r1
      r2 = _nt_s
      s0 << r2
      if r2
        if input.index('=', index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('=')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            r5 = _nt_set
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Affectation0)
      r0.extend(Affectation1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:affectation][start_index] = r0

    return r0
  end

  module Symbol0
  end

  def _nt_symbol
    start_index = index
    if node_cache[:symbol].has_key?(index)
      cached = node_cache[:symbol][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(/[A-Z]/, index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(/[a-z]/, index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Symbol0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:symbol][start_index] = r0

    return r0
  end

  module Set0
    def s
      elements[1]
    end

    def couples
      elements[2]
    end

    def s
      elements[3]
    end

  end

  module Set1
			def value
				couples.value
			end
  end

  def _nt_set
    start_index = index
    if node_cache[:set].has_key?(index)
      cached = node_cache[:set][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('{', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('{')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_s
      s0 << r2
      if r2
        r3 = _nt_couples
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            if input.index('}', index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure('}')
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Set0)
      r0.extend(Set1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:set][start_index] = r0

    return r0
  end

  def _nt_couples
    start_index = index
    if node_cache[:couples].has_key?(index)
      cached = node_cache[:couples][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_couples_b
    if r1
      r0 = r1
    else
      r3 = _nt_couple
      if r3
        r2 = r3
      else
        r2 = SyntaxNode.new(input, index...index)
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:couples][start_index] = r0

    return r0
  end

  module CouplesB0
    def couple
      elements[0]
    end

    def couples_b
      elements[2]
    end
  end

  module CouplesB1
			def value
				rv = [] if !rv
				rv << couple.value
				rv += couples_b.value
				rv
			end
  end

  def _nt_couples_b
    start_index = index
    if node_cache[:couples_b].has_key?(index)
      cached = node_cache[:couples_b][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_couple
    s1 << r2
    if r2
      if input.index(',', index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(',')
        r3 = nil
      end
      s1 << r3
      if r3
        r4 = _nt_couples_b
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(CouplesB0)
      r1.extend(CouplesB1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_couple
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:couples_b][start_index] = r0

    return r0
  end

  module Couple0
    def s
      elements[1]
    end

    def n1
      elements[2]
    end

    def s
      elements[3]
    end

    def s
      elements[5]
    end

    def n2
      elements[6]
    end

    def s
      elements[7]
    end

  end

  module Couple1
			def value
				[n1.value,n2.value]
			end
  end

  def _nt_couple
    start_index = index
    if node_cache[:couple].has_key?(index)
      cached = node_cache[:couple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('(', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_s
      s0 << r2
      if r2
        r3 = _nt_number
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            if input.index(',', index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(',')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_s
              s0 << r6
              if r6
                r7 = _nt_number
                s0 << r7
                if r7
                  r8 = _nt_s
                  s0 << r8
                  if r8
                    if input.index(')', index) == index
                      r9 = (SyntaxNode).new(input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure(')')
                      r9 = nil
                    end
                    s0 << r9
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Couple0)
      r0.extend(Couple1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:couple][start_index] = r0

    return r0
  end

  module Number0
  end

  module Number1
			def value
				text_value.to_i
			end
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('0', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('0')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      if input.index(/[1-9]/, index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      s2 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(/[0-9]/, index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        r4 = SyntaxNode.new(input, i4...index, s4)
        s2 << r4
      end
      if s2.last
        r2 = (SyntaxNode).new(input, i2...index, s2)
        r2.extend(Number0)
        r2.extend(Number1)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:number][start_index] = r0

    return r0
  end

  def _nt_calcul
    start_index = index
    if node_cache[:calcul].has_key?(index)
      cached = node_cache[:calcul][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_display

    node_cache[:calcul][start_index] = r0

    return r0
  end

  module Display0
  			def action
  				'a_display'
  			end
  end

  def _nt_display
    start_index = index
    if node_cache[:display].has_key?(index)
      cached = node_cache[:display][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_symbol
    r0.extend(Display0)

    node_cache[:display][start_index] = r0

    return r0
  end

  def _nt_s
    start_index = index
    if node_cache[:s].has_key?(index)
      cached = node_cache[:s][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(' ', index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(' ')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)

    node_cache[:s][start_index] = r0

    return r0
  end

end

class RelParser < Treetop::Runtime::CompiledParser
  include Rel
end

