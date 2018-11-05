require 'date'

class ATM

  attr_reader :balance, :transactions

  def initialize
    @transactions = []
    @balance = 0 
  end

  def bank_statement
    string_of_table = "date || credit || debit || balance"
    transactions.each do |transaction|
      string_of_table += "\n#{transaction[:date]} || #{transaction[:credit]} || #{transaction[:debit]} || #{transaction[:balance]}"
    end
    string_of_table
  end

  def deposit(money)
    @balance += money
    @transactions << { date: todays_date, credit: money, balance: balance }
  end

  private 

  def todays_date
    Date.today.strftime('%d/%m/%Y')
  end
end
