module Enumerable

  def my_each
    for i in 0...self.length
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i)
    end
  end

  def my_select
      result = []
      self.my_each do |i|
         if yield(i)
           result.<<(i)
         end
      end
      result
  end

  def my_all?
    self.my_each do |i|
      if yield(i) == true
        return true
      else
        return false
      end
    end
  end


end

=begin
arrayx = [2,4,6,8,10]
arrayx.my_each do |x|
  puts x * 2
end

arrayx = ["miden","uno","two","drei"]
arrayx.my_each_with_index do |x,y|
  puts "#{x} = #{y}"
end

arrayx = [1, 2, 3, 4, 5]
arrayx.my_select do |x|
    puts x if x > 3
end

arr = ["Jasan", "John", "Jean","Jelean"]
arr.my_all? do |name|
    print "yeah" if name[-1] == "n"
end

=end
