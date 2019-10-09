# frozen_string_literal: true
module Enumerable

  def my_each
    for i in self
      yield i
    end
  end

  def my_each_with_index
    i = 0
    for j in self
      yield j, i
      i += 1
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

  def my_count(item = nil)
    count = 0
    for i in self
      if item != nil
        count += 1 if i == item
      elsif block_given?
        count += 1 if yield i
      else
        count += 1
      end
    end
    count
  end

  def my_map(proc = nil)
    arry = []
    if proc != nil
      for i in self
        element = proc.call(i)
        arry << element
      end
    else
      for i in self
        element = yield i
        arry << element
      end
    end
    arry
  end

  def my_inject (initial = 0)
    i = 0
    accumulator = initial
    while (i < self.length)
      accumulator = yield(accumulator, self[i])
      i = i + 1
    end
    accumulator
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
arrayx = %w[jasa Joh Jean Jelean]
arrayx.my_all? do |name|
  name[-1] == 'n'
end
puts 'my_any'
arrayx = %w[jasa Joh Jean Jelean]
arrayx.my_any? do |name|
  name[-1] == 'n'
end
puts 'my_none'
arrayx = %w[jasa Joh Jean Jelean]
arrayx.my_none? do |name|
  name[-1] == 'n'
end
puts 'my_count'
arrayx = %w[jasa Joh Jean Jelean]
puts arrayx.my_count
puts 'my_map'
arrayx = %w[jasa Joh Jean Jelean].my_map { |x| x + '!'  }
puts arrayx
puts "my_inject"
def multiply_els(array=Array.new)
  array.my_inject(1) { |total, x| total * x }
end
puts multiply_els([2,2,4])
