module Enumerable

  def my_each
    return to_enum :my_each unless block_given?
    check_self = is_a?(Range) ? to_a : self
    i = 0
    while i < check_self.length
      yield(check_self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?
    i = 0
    my_each { |item| yield item, i, i += 1 }
    self
  end

  def my_select
    return to_enum :my_select unless block_given?
    return_arr = []
    my_each { |item| return_arr << item if yield(item) }
    return_arr
  end
  

  def my_all?
    return true if !block_given?
    if self.is_a? Hash
      self.my_each { |m, n| return false if !yield(m, n) }
    else
      self.my_each { |i| return false if !yield(i) }
    end
    true
  end

  def my_any?
    return true if !block_given?
    if self.is_a? Hash
      self.my_each { |m, n| return true if yield(m, n) }
    else
      self.my_each { |i| return true if yield(i) }
    end
    false
  end

  def my_none?
    return false unless block_given?
    if self.class == Hash
      self.my_each do |m, n|
        return false if yield(m, n)
      end
    else
      self.my_each do |i|
        return false if yield(i)
      end
    end
    true
  end

  def my_count?
    return self.length unless block_given?
    count = 0
    self.my_each { |i| count += 1 if yield(i) }
    count
  end

  def my_map(proc = nil)
    arry = []
    if !proc.nil?
      for i in self
        element = proc.call(i)
        arry << element
      end
    else
      for i in self
        element = yield(i)
        arry << element
      end
    end
    arry
  end

  def my_inject(*start_num)
      result = 0
      if start_num.count == 0
          self.my_each {|num|
              result = yield(result, num)
          }
      return result
      else
          start_num = start_num[0]
          self.my_each {|num|
              start_num = yield(start_num, num)
          }
          return start_num
      end
  end
end
