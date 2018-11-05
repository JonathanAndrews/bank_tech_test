require 'statement'


describe Statement do
  context 'Brand new bank account' do
    let(:no_transactions) { [] }
    let(:statement) { described_class.new }
    describe 'Statement#print_out' do
      it "prints out blank bank statement" do
        printed_statement = statement.print_out(no_transactions)
        expect(printed_statement).to eq("date || credit || debit || balance")
      end
    end 
  end

  context 'Statement after transactions' do
    
    let(:credit_transaction) { { date: '05/11/2018', credit: 1, balance: 1 } }
    let(:debit_transaction) { { date: '05/11/2018', debit: 1, balance: -1 } }
    let(:transactions) { [] }
    let(:statement) { described_class.new }

    describe 'Statement#print_out' do
      it 'prints out bank statement with one row after a deposit' do
        transactions << credit_transaction
        string_of_table = "date || credit || debit || balance\n05/11/2018 || 1 ||  || 1"
        
        printed_statement = statement.print_out(transactions)
        expect(printed_statement).to eq(string_of_table)
      end
    
      it 'prints out bank statement with one row after withdraw' do
        transactions << debit_transaction
        string_of_table = "date || credit || debit || balance\n05/11/2018 ||  || 1 || -1"
        
        printed_statement = statement.print_out(transactions)
        expect(printed_statement).to eq(string_of_table)
      end

      it 'prints out bank statement with 3 row in reverse chronological order' do
        transactions << debit_transaction
        transactions << credit_transaction
        transactions << credit_transaction
        transactions << credit_transaction
        transactions << credit_transaction
        string_of_table = "date || credit || debit || balance\n"\
                          "05/11/2018 || 1 ||  || 3\n"\
                          "05/11/2018 || 1 ||  || 2\n"\
                          "05/11/2018 || 1 ||  || 1\n"\
                          "05/11/2018 || 1 ||  || 0\n"\
                          "05/11/2018 ||  || 1 || -1"
                          
        
        printed_statement = statement.print_out(transactions)
        expect(printed_statement).to eq(string_of_table)
      end
    end 

  end
end