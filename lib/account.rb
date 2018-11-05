require 'date'

class Account

  attr_reader :balance, :transactions

  def initialize
    @transactions = []
    @balance = 0 
  end

  def bank_statement
    string_of_table = "date || credit || debit || balance"
    transactions.each do |transaction|
      date = transaction[:date]
      credit = transaction[:credit]
      debit = transaction[:debit]
      balance = transaction[:balance]
      string_of_table += "\n#{date} || #{credit} || #{debit} || #{balance}"
    end
    string_of_table
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
