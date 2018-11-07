# frozen_string_literal: true

require 'account'

context 'Feature Tests' do
  describe Account do
    context 'Brand new bank account' do
      let(:account) { described_class.new }
      describe 'Account#bank_statement' do
        it 'prints out blank bank statement' do
          blank_statement = "date || credit || debit || balance\n"
          expect { account.bank_statement }.to output(blank_statement).to_stdout
        end
      end
    end

    context 'Transactions' do
      let(:account) { described_class.new }
      describe 'Account#deposit' do
        it 'makes a credit transaction object' do
          the_date = Date.new(2018, 11, 5)
          allow(Date).to receive(:today).and_return(the_date)

          returned_hash = { date: the_date, credit: 1, debit: nil }
          expect(account.deposit(1)).to eq([returned_hash])
        end

        it 'increases the balance by specified amount' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

          account.deposit(9.5)
          expect(account.balance).to eq(9.5)
        end
      end

      describe 'Account#withdraw' do
        it 'makes a debit transaction object' do
          the_date = Date.new(2018, 11, 5)
          allow(Date).to receive(:today).and_return(the_date)

          deposit_hash = { date: the_date, debit: nil, credit: 1 }
          withdraw_hash = { date: the_date, debit: 1, credit: nil }
          account.deposit(1)
          expect(account.withdraw(1)).to eq([deposit_hash, withdraw_hash])
        end

        it 'decreases the balance by specified amount' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))

          account.deposit(10)
          account.withdraw(4)
          expect(account.balance).to eq(6)
        end
      end

      describe 'Account#bank_statement' do
        it 'prints out bank statement with one row after deposit' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))
          string_of_table = "date || credit || debit || balance\n"\
                            "05/11/2018 || 1.00 || || 1.00 \n"
          account.deposit(1)
          expect { account.bank_statement }.to output(string_of_table).to_stdout
        end

        it 'prints out bank statement with after withdraw' do
          allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))
          string_of_table = "date || credit || debit || balance\n"\
                            "05/11/2018 || || 1.00 || 1.00 \n"\
                            "05/11/2018 || 2.00 || || 2.00 \n"
          account.deposit(2)
          account.withdraw(1)
          expect { account.bank_statement }.to output(string_of_table).to_stdout
        end
      end
    end

    context 'Guarding against Misuse' do
      let(:account) { described_class.new }

      describe 'If someone tries to deposit a String' do
        it 'should throw an error "Non-numerical Input"' do
          expect { account.deposit('A String') }.to raise_error\
            'Non-numerical Input'
        end
      end

      describe 'If someone tries to withdraw a Array' do
        it 'should throw an error "Non-numerical Input"' do
          expect { account.withdraw([]) }.to raise_error\
            'Non-numerical Input'
        end
      end

      describe 'If someone tries to withdraw a instance of Object' do
        it 'should throw an error "Non-numerical Input"' do
          expect { account.withdraw(Object.new) }.to raise_error\
            'Non-numerical Input'
        end
      end

      describe 'If someone tries to deposit an Invalid Numerical Input' do
        it 'should throw an error "Invalid Numerical Input"' do
          expect { account.deposit(1.0001) }.to raise_error\
            'Invalid Numerical Input'
        end
      end

      describe 'If someone tries to withdraw an Invalid Numerical Input' do
        it 'should throw an error "Invalid Numerical Input"' do
          expect { account.withdraw(1.0001) }.to raise_error\
            'Invalid Numerical Input'
        end
      end

      describe 'If someone tries to deposit a Negative Number' do
        it 'should throw an error "Input must be a Positive Number"' do
          expect { account.deposit(-1) }.to raise_error\
            'Input must be a Positive Number'
        end
      end

      describe 'If someone tries to withdraw a Negative Number' do
        it 'should throw an error "Input must be a Positive Number"' do
          expect { account.withdraw(-1) }.to raise_error\
            'Input must be a Positive Number'
        end
      end
    end

    context 'Account cannot have negative bank balance' do
      let(:account) { described_class.new }

      describe 'If someone tries to withdraw more money than they have' do
        it 'should throw an error "Insufficient Funds"' do
          expect { account.withdraw(1) }.to raise_error\
            'Insufficient Funds'
        end
      end
    end
  end
end
