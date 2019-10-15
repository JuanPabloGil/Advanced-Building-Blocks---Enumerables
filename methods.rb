# frozen_string_literal: true

# methos of ruby: each, each_with_index, my_select, my_all?, my_any?, my_none?, my_count, my_map, my_injection
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
    my_each { |x| yield x, i, i += 1 }
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

    arr = []
    my_each { |x| arr << x if yield(x) }
    arr
  end

  def my_all?(param = nil)
    all = true
    if block_given?
      my_each { |x| unless yield(x) then all = false; break end }
    elsif param
      my_each { |x| return false unless pattern?(x, param) }
    else
      my_each { |x| unless x then all = false; break end }
    end
    all
  end

  def my_any?(param = nil)
    any = false
    if block_given?
      my_each { |x| if yield(x) then any = true; break end }
    elsif param
      my_each {|x | return true if pattern?(x, param) }
    else
      my_each { |x| if x then any = true; break end }
    end
    any
  end

  def my_none?(param = nil, &block)
    !my_any?(param, &block)
  end

  def pattern?(obj, pattern)
    (obj.respond_to?(:eql?) && obj.eql?(pattern)) ||
    (pattern.is_a?(Class) && obj.is_a?(pattern)) ||
    (pattern.is_a?(Regexp) && pattern.match(obj))
  end

  def my_count(param = nil)
    i = 0
    if block_given?
      my_each { |x| i += 1 if yield(x) == true }
    else
      return length if param.nil?

      my_each { |x| i += 1 if x == param }
    end
    i
  end

  def my_map
    return to_enum :my_map unless block_given?

    arr = []
    my_each { |item| arr << yield(item) }
    arr
  end

  def my_inject(param1 = nil, param2 = nil)
    check_self = is_a?(Range) ? to_a : self
    accumulator = param1.nil? || param1.is_a?(Symbol) ? check_self[0] : param1
    if block_given? && param1
      check_self[0..-1].my_each do |item|
        accumulator = yield(accumulator, item)
      end
    end

    if block_given? && !param1
      check_self[1..-1].my_each do |item|
        accumulator = yield(accumulator, item)
      end
    end

    if param1.is_a?(Symbol)
      check_self[1..-1].my_each do |i|
        accumulator = accumulator.send(param1, i)
      end
    end

    if param2
      check_self[0..-1].my_each do |i|
        accumulator = accumulator.send(param2, i)
      end
    end
    accumulator
  end
end
