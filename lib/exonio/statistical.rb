module Exonio
  module Statistical

    # Sum of all numbers
    #
    # @param numbers_ary [array] and array of numbers to sum all elements
    #
    # @return [float]
    #
    # @example
    #   Exonio.sum([1,2,3,4,5]) # => 15
    def sum(numbers_ary)
      numbers_ary.inject(0, :+)
    end

    # Simple mean formula: sum elements and / by length
    #
    # @param numbers_ary [array] an array of numbers to calculate the mean
    #
    # @return [float]
    #
    # @example
    #   Exonio.mean([1,2,3,4,5]) # => 3.0
    def mean(numbers_ary)
      numbers_ary.inject{ |sum, el| sum + el }.to_f / numbers_ary.size
    end

    # Median formula
    # @param numbers_ary [array] an array of numbers
    #
    # @return [float]
    #
    # @example
    #   Exonio.median([1,2,3,4,5]) # => 3.0
    def median(numbers_ary)
      numbers_ary.sort!
      len = numbers_ary.length
      (numbers_ary[(len - 1) / 2] + numbers_ary[len / 2]) / 2.0
    end
  end
end
