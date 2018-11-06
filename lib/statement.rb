
# frozen_string_literal: true

# The Statement class prints a Statement for the user.
class Statement
  COLUMN_TITLES = 'date || credit || debit || balance'

  def print_out(transactions)
    table_rows = ''
    balance = 0

    transactions.each do |transaction|
      balance = balance + transaction[:credit].to_i - transaction[:debit].to_i
      table_rows = "\n#{transaction[:date]} || #{transaction[:credit]} ||"\
                   " #{transaction[:debit]} || #{balance}#{table_rows}"
    end

    COLUMN_TITLES + table_rows
  end
end
