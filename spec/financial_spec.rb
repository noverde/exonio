require 'spec_helper'
require 'bigdecimal'

describe Exonio::Financial do
  describe '#fv' do
    let(:rate) { 0.05 / 12 }
    let(:nper) { 12 * 10 }
    let(:pv) { -100.00 }
    let(:pmt) { -100.00 }

    it 'computes fv with default arguments' do
      results = Exonio.fv(rate, nper, pmt, pv)

      expect(results).to eq(15692.928894335748)
    end

    it 'computes fv when payments are due at beginning' do
      results = Exonio.fv(rate, nper, pmt, pv, 1)

      expect(results).to eq(15757.629844104778)
    end
  end

  describe '#ipmt' do
    let(:rate) { 0.075 / 12 }
    let(:nper) { 12 * 2 }
    let(:per) { 8 }
    let(:pv) { 5000.00 }

    it 'computes ipmt with default arguments' do
      results = Exonio.ipmt(rate, per, nper, pv)

      expect(results).to eq(-22.612926783996798)
    end

    it 'computes ipmt with fv argument' do
      results = Exonio.ipmt(rate, per, nper, pv, 1000)

      expect(results).to eq(-20.88551214079616)
    end

    it 'computes ipmt when payments are due at beginning' do
      results = Exonio.ipmt(rate, per, nper, pv, 0, 1)

      expect(results).to eq(-22.47247382260551)
    end

    it 'returns zero when per and end_or_beginning are 1' do
      results = Exonio.ipmt(rate, 1, nper, pv, 0, 1)

      expect(results).to be_zero
    end
  end

  describe '#nper' do
    let(:rate) { 0.07 / 12 }
    let(:pmt) { -150.00 }
    let(:pv) { 8000.00 }
    let(:fv) { 1000.00 }

    it 'computes nper with default arguments' do
      results = Exonio.nper(rate, pmt, pv)

      expect(results).to eq(64.07334877066185)
    end

    it 'computes nper with fv argument' do
      results = Exonio.nper(rate, pmt, pv, fv)

      expect(results).to eq(70.63270889829036)
    end

    it 'computes nper when payments are due at beginning' do
      results = Exonio.nper(rate, pmt, pv, 0, 1)

      expect(results).to eq(63.62363537435202)
    end

    it 'computes nper with fv and due at beginning' do
      results = Exonio.nper(rate, pmt, pv, fv, 1)

      expect(results).to eq(70.14566694692749)
    end
  end

  describe '#pmt' do
    let(:rate) { 0.075 / 12 }
    let(:nper) { 12 * 15 }
    let(:pv) { 200_000.00 }
    let(:fv) { 10_000.00 }

    it 'computes pmt with default arguments' do
      results = Exonio.pmt(rate, nper, pv)

      expect(results).to eq(-1854.0247200054619)
    end

    it 'computes pmt with fv argument' do
      results = Exonio.pmt(rate, nper, pv, fv)

      expect(results).to eq(-1884.225956005735)
    end

    it 'computes pmt when payments are due at beginning' do
      results = Exonio.pmt(rate, nper, pv, 0, 1)

      expect(results).to eq(-1842.5090385147448)
    end

    it 'computes pmt with fv and due at beginning' do
      results = Exonio.pmt(rate, nper, pv, fv, 1)

      expect(results).to eq(-1872.522689198246)
    end
  end

  describe '#pv' do
    let(:rate) { 0.05 / 12 }
    let(:nper) { 12 * 10 }
    let(:pmt) { -100.00 }
    let(:fv) { 20_000.00 }

    it 'computes pv with default arguments' do
      results = Exonio.pv(rate, nper, pmt)

      expect(results).to eq(9428.135032823473)
    end

    it 'computes pv with fv argument' do
      results = Exonio.pv(rate, nper, pmt, fv)

      expect(results).to eq(-2715.0857731569663)
    end

    it 'computes pv when payments are due at beginning' do
      results = Exonio.pv(rate, nper, pmt, 0, 1)

      expect(results).to eq(9467.418928793571)
    end

    it 'computes pv with fv and due at beginning' do
      results = Exonio.pv(rate, nper, pmt, fv, 1)

      expect(results).to eq(-2675.801877186867)
    end
  end

  describe '#rate' do
    let(:nper) { 12 }
    let(:pmt) { 363.78 }
    let(:pv) { -3056.00 }

    it 'computes rate with default arguments' do
      results = Exonio.rate(nper, pmt, pv)

      expect(results).to eq(0.05963422268883278)
    end

    it 'computes rate with fv argument' do
      results = Exonio.rate(nper, pmt, pv, 10000, 1)

      expect(results).to eq(0.20020470756876815)
    end

    it 'computes rate when payments are due at beginning' do
      results = Exonio.rate(nper, pmt, pv, 0, 1)

      expect(results).to eq(0.07265012823626603)
    end

    context 'with large decimal scale' do
      let(:pmt) { BigDecimal("351.622169863986539264256777349669281495") }
      let(:pv) { BigDecimal("-3061.762000011") }

      it 'computes rate' do
        results = Exonio.rate(nper, pmt, pv) * 100

        expect(results.round(2)).to eq(5.32)
      end
    end
  end

  describe '#npv' do
    it 'computes the net present value' do
      results = Exonio.npv(0.281, CashflowFixture.cashflows)

      expect(results).to eq(-7787.382638079077)
    end

    context 'with large cashflows' do
      it 'does not raises infinite error' do
        expect { Exonio.npv(6.387405495738, CashflowFixture.cashflows) }.not_to raise_error
      end
    end
  end

  describe '#irr' do
    it 'computes the internal rate of return' do
      results = Exonio.irr(CashflowFixture.cashflows)

      expect(results.round(5)).to eq(0.00146)
    end
  end
end
