
class Statement

  COLUMN_TITLES = "date || credit || debit || balance"

  def print_out(transactions)
    string_of_table = COLUMN_TITLES
    transactions.each do |transaction|
      date = transaction[:date]
      credit = transaction[:credit]
      debit = transaction[:debit]
      balance = transaction[:balance]
      string_of_table += "\n#{date} || #{credit} || #{debit} || #{balance}"
    end
    string_of_table
  end
end