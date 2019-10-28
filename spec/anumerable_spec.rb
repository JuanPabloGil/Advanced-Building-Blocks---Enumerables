require './methods.rb'

describe Enumerable do
  let(:test_arr) { [1, 2, 3] }
  let(:test_block) { proc { |i| i * 2 } }
  let(:test_arr_str) { %w[one two three] }
  let(:test_length) { proc { |word| word.length >= 3 } }
  let(:test_length_2) { proc { |word| word.length >= 5 }  }
  let(:test_range) { (1..4) }
  let(:test_absolutes) { [nil, true, false] }
  let(:test_numeric) { [1, 2i, 3.14] }

  describe '#my_each' do
    it 'returns original array when no output' do
      expect(test_arr.my_each { test_block }).to eq(test_arr)
    end

    it 'prints result to stdout from block calculation i * 2' do
      expect { test_arr.my_each { |i| print i * 2 } }.to output(/246/).to_stdout
    end

    it 'returns an Enumerator when no block given' do
      expect(test_arr.my_each.is_a?(Enumerator)).to be(true)
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_arr.my_each { test_block }).to eq(test_arr.each { test_block })
      expect(test_arr.my_each.is_a?(Enumerator)).to eq(test_arr.each.is_a?(Enumerator))
    end
  end

  describe "#my_each_with_index" do
    it "It expect to be equal to 1 2 3" do
      expect(test_arr.my_each_with_index{test_block}).to eql(test_arr)
    end

    it "returns an Enumerator when no block given" do
      expect(test_arr.my_each_with_index.is_a?(Enumerator)).to eql(true)

    end
  end

  describe "#my_select" do

    it "Check if its an even" do
      expect(test_arr.my_select(&:even?)).to eql([2])
    end

    it "return an Enumerable when no block given" do
      expect(test_arr.my_select.is_a?(Enumerable)).to eql(true)
    end
  end


  describe "#my_all?" do

    it "Check the length of the words 1 with 3" do
      expect(test_arr_str.my_all?(&test_length)).to eql(true)
    end

    it "Check the length of the words 2 with 5" do
      expect(test_arr_str.my_all?(&test_length_2)).to eql(false)
    end
  end


  describe "#my_any?" do

    it "check if any of the elements have a length equal or bigger than three" do
      expect( test_arr_str.my_any?(&test_length)).to be true
    end
  end

  #it "return false when no block is given" do
  #    expect(test_absolutes.my_any?).to eql(false)
  #  end

  describe "#my_none?" do

    it "Return true when none with the test length 3" do
      expect(test_arr_str.my_none?(test_length)).to be true
    end

    it "Return true when none with the test length  5" do
      expect(test_arr_str.my_none?(test_length_2)).to be true
    end

    it "returns true when no block given with an empty array" do
      expect([].my_none?).to be true
    end

  end

  describe "#my_count" do

    it "Count the elements" do
      expect(test_arr.my_count).to eql(3)
    end

    it "Returns the number og items that match the positional argument given" do
      expect(test_arr.my_count(3)).to eql(1)
    end

    
  end


end
