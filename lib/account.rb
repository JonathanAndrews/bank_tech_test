require 'date'

class Account

  attr_reader :transactions, :statement

  def initialize(statement = Statement.new)
    @balance = 0
    @transactions = []
    @statement = statement
  end

  def bank_statement
    statement.print_out(transactions)
  end

  def deposit(money)
    @balance += money
    @transactions.unshift({ date: todays_date, credit: money })
  end

  def withdraw(money)
    @balance -= money
    @transactions.unshift({ date: todays_date, debit: money })
  end

  private 

  def todays_date
    Date.today.strftime('%d/%m/%Y')
  end
end
