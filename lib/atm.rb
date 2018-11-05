require 'date'

class ATM

  attr_reader :balance

  def initialize
    @transactions = []
    @balance = 0 
  end

  def bank_statement
    'date || credit || debit || balance'
  end

  def deposit(money)
    @balance += money
    @transactions << { date: todays_date, amount: money, balance: balance }
  end

  private 

  def todays_date
    Date.today.strftime('%d/%m/%Y')
  end
end
