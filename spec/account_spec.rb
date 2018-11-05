require 'account'

describe Account do
  context 'Brand new bank account' do

    let(:empty_array) { [] }
    let(:statement_double) { double :Statement }
    let(:log_double) { double :TransactionLog, log: empty_array }
    let(:account) { described_class.new(statement: statement_double, log: log_double) }

    describe 'Account#bank_statement' do
      it "calls Statement#print_out" do
        expect(statement_double).to receive(:print_out).with(empty_array)
        
        account.bank_statement
      end
    end 
  end

  context 'Transactions' do

    let(:account) { described_class.new }

    describe 'Account#deposit' do
      it 'makes a credit transaction object' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

        returned_hash = { date: '05/11/2018', credit: 1, debit: nil }
        expect(account.deposit(1)).to eq([returned_hash])
      end
    end 

    describe 'Account#withdraw' do
      it 'makes a debit transaction object' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

        returned_hash = { date: '05/11/2018', debit: 1, credit: nil }
        expect(account.withdraw(1)).to eq([returned_hash])
      end
    end 
  end

  context 'Guarding against Misuse' do
    let(:account) { described_class.new }

    describe 'If someone tries to deposit a String' do
      it 'should throw an error' do
        expect{ account.deposit("A String") }.to raise_error("A String is an invalid input")
      end
    end

    describe 'If someone tries to withdraw a String' do
      it 'should throw an error' do
        expect{ account.withdraw("A String") }.to raise_error("A String is an invalid input")
      end
    end
  end
end
