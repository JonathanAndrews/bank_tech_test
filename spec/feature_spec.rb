require "account"

context "Feature Tests" do
  describe Account do
    context 'Brand new bank account' do
      let(:account) { described_class.new }
      describe 'Account#bank_statement' do
        it "prints out blank bank statement" do
          statement = account.bank_statement
          expect(statement).to eq("date || credit || debit || balance")
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
  
      describe 'Account#bank_statement' do
        it 'prints out bank statement with one row after deposit' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))
          string_of_table = "date || credit || debit || balance\n"\
                            "05/11/2018 || 1 ||  || 1"
          account.deposit(1)
          expect(account.bank_statement).to eq(string_of_table)
        end
      end
  
      describe 'Account#withdraw' do
        it 'makes a debit transaction object' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))
  
          returned_hash = { date: '05/11/2018', debit: 1, credit: nil }
          expect(account.withdraw(1)).to eq([returned_hash])
        end
      end 
  
      describe 'Account#withdraw' do
        it 'prints out bank statement with one row after withdraw' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))
          string_of_table = "date || credit || debit || balance\n"\
                            "05/11/2018 ||  || 1 || -1"
          account.withdraw(1)
          expect(account.bank_statement).to eq(string_of_table)
        end
      end 
    end

    context 'Guarding against Misuse' do
      let(:account) { described_class.new }

      describe 'If someone tries to deposit a String' do
        it 'should throw an error "Non-numerical Input"' do
          expect{ account.deposit("A String") }.to raise_error("Non-numerical Input")
        end
      end

      describe 'If someone tries to withdraw a Array' do
        it 'should throw an error "Non-numerical Input"' do
          expect{ account.withdraw([]) }.to raise_error("Non-numerical Input")
        end
      end

      describe 'If someone tries to withdraw a instance of Object' do
        it 'should throw an error "Non-numerical Input"' do
          expect{ account.withdraw(Object.new) }.to raise_error("Non-numerical Input")
        end
      end

      describe 'If someone tries to deposit an Invalid Numerical Input' do
        it 'should throw an error "Invalid Numerical Input"' do
          expect{ account.deposit(1.0001) }.to raise_error("Invalid Numerical Input")
        end
      end

      describe 'If someone tries to withdraw anInvalid Numerical Input' do
        it 'should throw an error "Invalid Numerical Input"' do
          expect{ account.withdraw(1.0001) }.to raise_error("Invalid Numerical Input")
        end
      end
    end
  end
end
