require "atm"

context "Feature Tests" do
  describe ATM do
    context 'Brand new bank account' do
      let(:atm) { described_class.new }
      describe 'ATM#bank_statement' do
        it "prints out blank bank statement" do
          expect(atm.bank_statement).to eq('date || credit || debit || balance')
        end
      end 
    end
  
    context 'Transactions' do
      let(:atm) { described_class.new }
      describe 'ATM#deposit' do
        it "stores money in bank" do
          returned_hash = { date: '05/11/2018', amount: 1, balance: 1 }
          expect(atm.deposit(1)).to eq([returned_hash])
        end
      end 
    end
  end
end
