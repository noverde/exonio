module Exonio
  module Helpers
    class IrrHelper
      values = {
        eps: '1.0e-16',
        one: '1.0',
        two: '2.0',
        ten: '10.0',
        zero: '0.0'
      }

      values.each do |key, value|
        define_method key do
          BigDecimal.new(value)
        end
      end

      def initialize(transactions)
        @transactions = transactions
      end

      def values(x)
        value = Exonio.npv(x[0].to_f, @transactions)
        [ BigDecimal.new(value.to_s) ]
      end
    end
  end
end
