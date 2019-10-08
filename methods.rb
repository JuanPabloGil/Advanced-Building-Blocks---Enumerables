# magic
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
      result.<<(i) if yield(i)
    end
    result
  end

  def my_all?
    self.my_each { |i| return true if yield(i) }
    false
  end

  def my_any?
    self.my_each { |i| return true if yield(i) }
    false
  end

  def my_none?
    self.my_each { |i| return false if yield(i) }
    true
  end

  def my_count
    total = 0
    self.my_each do |i|
      total += 1 if yield(i)
    end
    total
  end
end

puts 'my_each'
arrayx = [2, 4, 6, 8, 10]
arrayx.my_each do |x|
  puts x * 2
end
puts 'my_each_with_index'
arrayx = %w[miden uno two drei]
arrayx.my_each_with_index do |x, y|
  puts "#{x} = #{y}"
end
puts 'my_select'
arrayx = [1, 2, 3, 4, 5]
arrayx.my_select do |x|
  puts x if x > 3
end
puts 'my_all'
arr = %w[jasa Joh Jean Jelean]
arr.my_all? do |name|
  name[-1] == 'n'
end
puts 'my_any'
arr = %w[jasa Joh Jean Jelean]
arr.my_any? do |name|
  name[-1] == 'n'
end
puts 'my_none'
arr = %w[jasa Joh Jean Jelean]
arr.my_none? do |name|
  name[-1] == 'n'
end
