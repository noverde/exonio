require 'spec_helper'

describe Exonio::Statistical do
  describe '#sum' do
    let(:ary) {[1, 2, 3, 4, 5, 6]}

    it 'returns 0 if array is empty' do
      results = Exonio.sum([])

      expect(results).to be_zero
    end

    it 'returns the sum of all elements' do
      results = Exonio.sum(ary)

      expect(results).to eq(21)
    end

    it 'raise error (string/nil in array)' do
      expect { Exonio.sum(ary << 'what') }.to raise_error(TypeError)
    end
  end

  describe '#mean' do
    let(:ary) {[1, 2, 3, 4, 5, 6]}

    it 'returns the mean' do
      results = Exonio.mean(ary)

      expect(results).to eq(3.5)
    end

    it 'raise TypeError (string/nil in array)' do
      expect { Exonio.mean(ary << nil) }.to raise_error(TypeError)
    end
  end

  describe 'median' do
    let(:ary) {[1, 2, 3, 6, 4]}

    it 'returns the median' do
      results = Exonio.median(ary)

      expect(results).to eq(3.0)
    end

    it 'raise ArgumentError (nil in array)' do
      expect { Exonio.median(ary << nil) }.to raise_error(ArgumentError)
    end

    it 'raise ArgumentError (string in array)' do
      expect { Exonio.median(ary << 'what') }.to raise_error(ArgumentError)
    end
  end
end
