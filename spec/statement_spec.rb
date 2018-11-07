# frozen_string_literal: true

require 'statement'

describe Statement do
  context 'Brand new bank account' do
    let(:no_transactions) { [] }
    let(:statement) { described_class.new }
    describe 'Statement#print_out' do
      it 'prints out blank bank statement' do
        string_of_table = "date || credit || debit || balance\n"
        expect do
          statement.print_out(no_transactions)
        end.to output(string_of_table).to_stdout
      end
    end
  end

  context 'Statement after transactions' do
    let(:credit_transaction) { { date: Date.new(2018, 11, 5), credit: 1, balance: 1 } }
    let(:debit_transaction) { { date: Date.new(2018, 11, 5), debit: 1, balance: -1 } }
    let(:transactions) { [] }
    let(:statement) { described_class.new }

    describe 'Statement#print_out' do
      it 'prints out bank statement with one row after a deposit' do
        transactions << credit_transaction
        string_of_table = "date || credit || debit || balance\n"\
                          "05/11/2018 || 1.00 || || 1.00 \n"
                          
        expect do
          statement.print_out(transactions)
        end.to output(string_of_table).to_stdout
      end

      it 'prints out bank statement with one row after withdraw' do
        transactions << debit_transaction
        string_of_table = "date || credit || debit || balance\n"\
                          "05/11/2018 || || 1.00 || -1.00 \n"

        expect do
          statement.print_out(transactions)
        end.to output(string_of_table).to_stdout
      end

      it 'prints out bank statement in reverse chronological order' do
        transactions << debit_transaction
        transactions << credit_transaction
        transactions << credit_transaction
        transactions << credit_transaction
        transactions << credit_transaction
        string_of_table = "date || credit || debit || balance\n"\
                          "05/11/2018 || 1.00 || || 3.00 \n"\
                          "05/11/2018 || 1.00 || || 2.00 \n"\
                          "05/11/2018 || 1.00 || || 1.00 \n"\
                          "05/11/2018 || 1.00 || || 0.00 \n"\
                          "05/11/2018 || || 1.00 || -1.00 \n"

        expect do
          statement.print_out(transactions)
        end.to output(string_of_table).to_stdout
      end
    end
  end
end
