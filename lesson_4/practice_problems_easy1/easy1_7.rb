=begin
What is the default return value of to_s when invoked on an object?
Where could you go to find out if you want to be sure?

The default is to return the object class and encoding.
If unsure, you can look in the (custom) class definition and see if it overrides the 
default to_s method, and if not, you can look in the Ruby docs.
=end
