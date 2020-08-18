module Stomach
  def eat(food)
    @contents ||= []
    @contents << food
  end

  def vomit
    @contents.pop
  end
end

class Lifeform
  attr_reader :dna

  def initialize(dna = [])
    @dna = dna
  end

  def reproduce(other = nil)
    return clone unless other
    new_dna = dna.zip(other.dna).flatten
    self.class.new(new_dna)
  end
end

class Person < Lifeform
  # Person can inherit from lifeform which makes sense
  # because all persons are lifeforms, but can also
  # gain stomach features (not shared by all lifeforms)
  # by including a module. As opposed to putting stomach
  # features into a base class. Requiring all stomach-havers
  # to inherit from that, and almost definitely ending up
  # with a bunch of other stuff you don't need or want
  # as the base class bloats because you've muddied the hierarchy.
  include Stomach
end

p = Person.new
p.eat("hot dog")  # => ["hot dog"]
p.vomit           # => "hot dog"
p.reproduce       # => #<Person:...>

p1 = Person.new([1, 2])
p2 = Person.new([3, 4])
puts p1.reproduce(p2).dna.inspect
