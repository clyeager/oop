#1.Create a Person class, given this usage

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name # => Robert

#2.Change your class to add the following usage

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    @first_name = full_name.split.first
    full_name.split.size == 1 ? @last_name = '' : @last_name = full_name.split.last
  end

  def name
    first_name + ' ' + last_name
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name     # => 'Robert Smith'

#3.Now create a smart name= method that can take just a first name or a full name, and knows how to
# set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    split_full_name(full_name)
  end

  def name=(full_name)
    split_full_name(full_name)
  end

  def name
    first_name + ' ' + last_name
  end

  private

  def split_full_name(full_name)
    self.first_name = full_name.split.first
    full_name.split.size == 1 ? self.last_name = '' : self.last_name = full_name.split.last
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name     # => 'Robert Smith'

#4.Creating the following two people, how can we tell if the two names are the same?

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

bob.name == rob.name

#5.If we add the following what will print?

  def to_s
    name
  end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

#This prints the name method because string interpolation calls to_s on the bob instance, and to_s returns
# the name method.

