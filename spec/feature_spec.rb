# frozen_string_literal: true

require 'account'

context 'Acceptance Test' do
  describe Account do
    let(:account) { described_class.new }
    describe 'Account#bank_statement' do
      it 'prints out bank statement with after withdraw' do
        allow(Date).to receive(:today).and_return(Date.new(2018, 11, 5))
        string_of_table = "date || credit || debit || balance\n"\
                          "05/11/2018 || || 500.00 || 2500.00 \n"\
                          "05/11/2018 || 2000.00 || || 3000.00 \n"\
                          "05/11/2018 || 1000.00 || || 1000.00 \n"

        account.deposit(1000)
        account.deposit(2000)
        account.withdraw(500)
        expect { account.bank_statement }.to output(string_of_table).to_stdout
      end
    end
  end
end


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
  end
end
