# frozen_string_literal: true

require 'date'

# The TransactionLog class stores the user's transactions.
class TransactionLog
  attr_reader :log

  def initialize
    @log = []
  end

  def add(credit: nil, debit: nil)
    @log << { date: Date.today, credit: credit, debit: debit }
  end
  
end