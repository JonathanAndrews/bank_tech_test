
# frozen_string_literal: true

# The Statement class prints a Statement for the user.
class Statement
  COLUMN_TITLES = 'date || credit || debit || balance'

  def print_out(transactions)
    table_rows = ''
    balance = 0

    transactions.each do |transaction|
      credit = transaction[:credit]
      debit = transaction[:debit]
      balance = balance + credit.to_f - debit.to_f
      table_rows = "\n#{transaction[:date]} || #{money_syntax(credit)}||"\
        " #{money_syntax(debit)}|| #{money_syntax(balance)}#{table_rows}"
    end

    puts COLUMN_TITLES + table_rows
  end

  def money_syntax(number)
    format('%.2f', number) + ' ' unless number.nil?
  end
end
