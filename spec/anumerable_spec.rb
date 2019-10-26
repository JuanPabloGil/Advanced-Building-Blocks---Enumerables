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


end
