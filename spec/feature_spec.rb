require "atm"

describe ATM do
  let(:atm) { described_class.new }
  it "prints out blank bank statement" do
    expect(atm.bank_statement).to eq("date || credit || debit || balance")
  end
end
