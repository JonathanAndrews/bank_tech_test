# frozen_string_literal: true

require 'transaction_log'

describe TransactionLog do
  let(:transaction_log) { described_class.new }

  describe '#initialize' do
    it 'method creates an empty log array' do
      expect(transaction_log.log).to eq([])
    end
  end

  describe '#add' do
    it 'inserts a credit transaction hash into the index 0 postion' do
      allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

      returned_hash = { date: '05/11/2018', credit: 1, debit: nil }
      transaction_log.add(credit: 1)
      expect(transaction_log.log).to eq([returned_hash])
    end

    it 'inserts a debit transaction hash into the index 0 postion' do
      allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

      returned_hash = { date: '05/11/2018', credit: nil, debit: 1 }
      transaction_log.add(debit: 1)
      expect(transaction_log.log).to eq([returned_hash])
    end
  end
end
