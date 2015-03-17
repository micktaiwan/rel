## What ##
Algebraic Relation Calculator implemented in ruby
thanks to [Treetop](http://treetop.rubyforge.org/index.html)

```
> A = {(0,1),(2,3)}
> B = {(0,1),(1,2)}
> A+B  # union
{(0,1),(1,2),(2,3)}
> A/B  # intersection
{(0,1)}
```

## Installation ##

  * gem install treetop -y
  * svn checkout http://rel.googlecode.com/svn/trunk/ rel
  * cd rel
  * ruby main.rb
