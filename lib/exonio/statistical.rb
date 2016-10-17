module Exonio
  module Statistical
    # Write something
    #
    # @param numbers_ary [marray] an number`s array to calculate the mean
    #
    # @return [float]
    #
    # @Example
    #   exonio.mean([1,2,3,4,5]) # ==> 3.0
    def mean(numbers_ary)
      numbers_ary.inject{ |sum, el| sum + el }.to_f / numbers_ary.size
    end

  end
end
