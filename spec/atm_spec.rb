require "atm"

describe ATM do
  context 'Brand new bank account' do
    let(:atm) { described_class.new }
    describe 'ATM#bank_statement' do
      it "prints out blank bank statement" do
        expect(atm.bank_statement).to eq("date || credit || debit || balance")
      end
    end 
  end

  context 'Transactions' do
    let(:atm) { described_class.new }
    describe 'ATM#deposit' do
      it 'makes a credit transaction object' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

        returned_hash = { date: '05/11/2018', credit: 1, balance: 1 }
        expect(atm.deposit(1)).to eq([returned_hash])
      end
    end 

    describe 'ATM#bank_statement' do
      it 'prints out bank statement with one row after deposit' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

        atm.deposit(1)
        expect(atm.bank_statement).to eq("date || credit || debit || balance\n05/11/2018 || 1 ||  || 1")
      end
    end

    describe 'ATM#withdraw' do
      it 'makes a debit transaction object' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

        returned_hash = { date: '05/11/2018', debit: 1, balance: -1 }
        expect(atm.withdraw(1)).to eq([returned_hash])
      end
    end 

    describe 'ATM#withdraw' do
      it 'prints out bank statement with one row after withdraw' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

        atm.withdraw(1)
        expect(atm.bank_statement).to eq("date || credit || debit || balance\n05/11/2018 ||  || 1 || -1")
      end
    end 

  end
end