
class Statement

  COLUMN_TITLES = "date || credit || debit || balance"

  def print_out(transactions)
    table_rows = ""
    balance = 0

    transactions.each do |transaction|
      date = transaction[:date]
      credit = transaction[:credit]
      debit = transaction[:debit]
      balance = balance + credit.to_i - debit.to_i
      table_rows = "\n#{date} || #{credit} ||"\
              " #{debit} || #{balance}#{table_rows}"
    end

    COLUMN_TITLES + table_rows
  end
end
