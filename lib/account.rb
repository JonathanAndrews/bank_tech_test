# frozen_string_literal: true

require 'date'
require_relative 'statement'

# The Account class tracks the user's balance.
class Account
  attr_reader :balance

  def initialize(statement: Statement.new)
    @balance = 0
    @transaction_log = []
    @statement = statement
  end

  def bank_statement
    @statement.print_out(@transaction_log)
  end

  def deposit(money)
    validate_input(money)
    @balance += money
    @transaction_log << { date: Date.today, credit: money }
  end

  def withdraw(money)
    validate_input(money)
    stop_overdraw(money)
    @balance -= money
    @transaction_log << { date: Date.today, debit: money }
  end

  private

  def validate_input(input)
    raise 'Non-numerical Input' unless float_or_integer?(input)
    raise 'Input must be a Positive Number' if input.negative?
    raise 'Invalid Numerical Input' if pounds_and_pennies?(input)
  end

  def stop_overdraw(money)
    raise 'Insufficient Funds' if money > balance
  end

  def pounds_and_pennies?(input)
    (input * 100) % 1 != 0
  end

  def float_or_integer?(input)
    input.instance_of?(Float) || input.instance_of?(Integer)
  end
end
