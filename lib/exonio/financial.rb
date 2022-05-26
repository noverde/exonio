module Exonio
  module Financial
    # Calculates the effective annual interest rate, given a nominal interest rate and the number of
    # compounding periods. Nominal interest rate is the stated rate on the financial product.
    # Effective annual interest rate is the interest rate actually earned due to compounding.
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The nominal interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of compounding periods
    #
    # @return [Float]
    #
    # @example
    #   Exonio.effect(0.05, 12 * 10) # ==> 0.05126014873337037
    #
    def effect(rate, nper)
      (1 + rate / nper) ** nper - 1
    end

    # Calculates the future value of an annuity investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of compounding periods
    # @param pmt [Float] The number of payments to be made
    # @param pv [Float] The present value
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.fv(0.05 / 12, 12 * 10, -100, -100) # ==> 15692.928894335748
    #
    def fv(rate, nper, pmt, pv, end_or_beginning = 0)
      temp = (1 + rate) ** nper
      fact = (1 + rate* end_or_beginning) * (temp - 1) / rate

      -(pv * temp + pmt * fact)
    end

    # Calculates the payment on interest for an investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param per [Integer] The amortization period, in terms of number of periods
    # @param nper [Integer] The number of payments to be made
    # @param pv [Float] The present value
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.ipmt(0.075 / 12, 8, 12 * 2, 5000) # ==> -22.612926783996798
    #
    def ipmt(rate, per, nper, pv, fv = 0, end_or_beginning = 0)
      pmt = self.pmt(rate, nper, pv, fv, end_or_beginning)
      fv = self.fv(rate, (per - 1), pmt, pv, end_or_beginning) * rate
      temp = end_or_beginning == 1 ? fv / (1 + rate) : fv

      (per == 1 && end_or_beginning == 1) ? 0.0 : temp
    end

    # Calculates the number of payment periods for an investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param pmt [Float] The payment amount made each period
    # @param pv [Float] The present value of the payments
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.nper(0.07 / 12, -150, 8000) # ==> 64.07334877066185
    #
    def nper(rate, pmt, pv, fv = 0, end_or_beginning = 0)
      return (-pv - fv) / pmt if rate.zero?

      z = pmt * (1 + rate * end_or_beginning) / rate
      temp = Math.log((-fv + z) / (pv + z))

      temp / Math.log(1 + rate)
    end

    # Calculates the periodic payment for an annuity investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of payments to be made (number of periods)
    # @param pv [Float] The present value of the annuity
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.pmt(0.075/12, 12*15, 200_000) # ==> -1854.0247200054619
    #
    def pmt(rate, nper, pv, fv = 0, end_or_beginning = 0)
      temp = (1 + rate) ** nper
      fact = (1 + rate * end_or_beginning) * (temp - 1) / rate

      -(fv + pv * temp) / fact
    end

    # Calculates the present value of an annuity investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of payments to be made (number of periods)
    # @param pmt [Float] The amount per period to be paid
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.pv(0.05/12, 12*10, -100, 20_000) # ==> -2715.0857731569663
    #
    def pv(rate, nper, pmt, fv = 0, end_or_beginning = 0)
      temp = (1 + rate) ** nper
      fact = (1 + rate * end_or_beginning) * (temp - 1) / rate

      -(fv + pmt * fact) / temp
    end

    # Calculates the interest rate of an annuity investment based on
    # constant-amount periodic payments and the assumption of a constant interest rate.
    #
    # @param nper [Integer] The number of payments to be made (number of periods)
    # @param pmt [Float] The amount per period to be paid
    # @param pv [Float] The present value
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    # @param rate_guess [Float] An estimate for what the interest rate will be
    #
    # @return [Float]
    #
    # @example
    #   Exonio.rate(12, 363.78, -3056.00) # ==> 0.05963422268883278
    #
    def rate(nper, pmt, pv, fv = 0, end_or_beginning = 0, rate_guess = 0.10)
      guess = rate_guess
      tolerancy = 1e-6
      close = false

      begin
        temp = newton_iter(guess, nper, pmt, pv, fv, end_or_beginning)
        next_guess = (guess - temp).round(20)
        diff = (next_guess - guess).abs
        close = diff < tolerancy
        guess = next_guess
      end while !close

      next_guess
    end

    # Calculates the net present value of an investment based on a
    # series of periodic cash flows and a discount rate.
    #
    # @param discount [Float] The discount rate of the investment over one period
    # @param cashflows [Array] The first future cash flow + additional future cash flows
    #
    # @return [Float]
    #
    # @example
    #   Exonio.npv(0.281, [-100, 39, 59, 55, 20]) # ==> -0.00661872883563408
    #
    def npv(discount, cashflows)
      total = 0

      cashflows.each_with_index do |cashflow, index|
        total += (cashflow.to_f / (1 + discount.to_f) ** (index + 1))
      end

      total
    end

    # Calculates the internal rate of return on an investment based on a
    # series of periodic cash flows.
    #
    # @param cashflows [Array] An array containing the income or payments
    # associated with the investment
    #
    # @return [Float]
    #
    # @example
    #   Exonio.irr([-100, 39, 59, 55, 20]) # ==> 0.28094842116...
    #
    def irr(values)
      func = Helpers::IrrHelper.new(values)
      guess = [ func.eps ]
      nlsolve( func, guess)
      guess[0]
    end

    private

    # This method was borrowed from the NumPy rate formula
    # which was generated by Sage
    #
    def newton_iter(r, n, p, x, y, w)
      t1 = (r+1)**n
      t2 = (r+1)**(n-1)
      ((y + t1*x + p*(t1 - 1)*(r*w + 1)/r) / (n*t2*x - p*(t1 - 1)*(r*w + 1)/(r**2) + n*p*t2*(r*w + 1)/r + p*(t1 - 1)*w/r))
    end
  end
end
