
# frozen_string_literal: true

# The Statement class prints a Statement for the user.
class Statement
  COLUMN_TITLES = 'date || credit || debit || balance'

  def print_out(transactions)
    table_rows = ''
    balance = 0

    transactions.each do |transaction|
      date_string = format_date(transaction[:date])
      credit = transaction[:credit]
      debit = transaction[:debit]
      balance = balance + credit.to_f - debit.to_f
      table_rows = "\n#{date_string} || #{format_money(credit)}||"\
        " #{format_money(debit)}|| #{format_money(balance)}#{table_rows}"
    end

    puts COLUMN_TITLES + table_rows
  end

  private
  
  def format_date(date_object)
    date_object.strftime('%d/%m/%Y')
  end

  def format_money(number)
    format('%.2f', number) + ' ' unless number.nil?
  end
end
