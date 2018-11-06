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
    misuse_protections(money)
    @balance += money
    transaction_log.add(credit: money)
  end

  def withdraw(money)
    misuse_protections(money)
    overdraw_protection(money)
    @balance -= money
    transaction_log.add(debit: money)
  end

  private

  def misuse_protections(input)
    raise "Non-numerical Input" unless float_or_integer?(input)
    raise "Invalid Numerical Input" if pounds_and_pennies?(input)
  end

  def overdraw_protection(money)
    raise "Insufficient Funds" if money > balance
  end

  def pounds_and_pennies?(input)
    (input * 100) % 1 != 0
  end

  def float_or_integer?(input)
    input.instance_of?(Float) || input.instance_of?(Integer)
  end
  
end
