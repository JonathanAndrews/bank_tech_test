require 'date'
require 'statement'
require 'transaction_log'

class Account

  attr_reader :transaction_log, :statement, :balance

  def initialize(statement: Statement.new, log: TransactionLog.new)
    @balance = 0
    @transaction_log = log
    @statement = statement
  end

  def bank_statement
    statement.print_out(transaction_log.log)
  end

  def deposit(money)
    @balance += money
    transaction_log.add(credit: money)
  end

  def withdraw(money)
    @balance -= money
    transaction_log.add(debit: money)
  end
end
