require 'spec_helper'

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
end
