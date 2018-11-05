require 'date'

class Account

  attr_reader :balance, :transactions, :statement

  def initialize(statement = Statement.new)
    @transactions = []
    @balance = 0 
    @statement = statement
  end

  def bank_statement
    statement.print_out(transactions)
  end

  def deposit(money)
    @balance += money
    @transactions << { date: todays_date, credit: money, balance: balance }
  end

  def withdraw(money)
    @balance -= money
    @transactions << { date: todays_date, debit: money, balance: balance }
  end

  private 

  def todays_date
    Date.today.strftime('%d/%m/%Y')
  end
end
