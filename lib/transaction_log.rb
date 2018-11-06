require 'date'

class TransactionLog

  attr_reader :log
  
  def initialize
    @log = []
  end

  def add(credit: nil, debit: nil)
    @log << { date: todays_date, credit: credit, debit: debit }
  end
end

private 

def todays_date
  Date.today.strftime('%d/%m/%Y')
end
