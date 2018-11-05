require 'transaction_log'

describe TransactionLog do
  
  describe 'TransactionLog#initialize' do

    let(:transaction_log) { described_class.new }

    it "method creates an empty log array" do
      expect(transaction_log.log).to eq([])
    end
  end 

  
end
