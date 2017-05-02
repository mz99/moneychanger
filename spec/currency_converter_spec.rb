require "spec_helper"

RSpec.describe CurrencyConverter do
  it "has a version number" do
    expect(CurrencyConverter::VERSION).not_to be nil
  end

  it "returns the right amount" do
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    expect(five_eur.amount).to eq(5)
  end

  it "inspects the right things" do
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    expect(five_eur.inspect).to eq("5 EUR")
  end

  it "converts to correct currency" do
    CurrencyConverter::Money.conversion_rates('EUR', {
      'USD'     => 1.09,
      'Bitcoin' => 0.00084,
      'GBP' => 0.85
    })
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    expect(five_eur.convert_to("USD")).to eq(5.45)
  end

  it "adds the correct amount" do
    CurrencyConverter::Money.conversion_rates('EUR', {
      'USD'     => 1.09,
      'Bitcoin' => 0.00084,
      'GBP' => 0.85
    })
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    expect(five_eur + five_eur).to eq(10)
  end

  it "subtracts the correct amount" do
    CurrencyConverter::Money.conversion_rates('EUR', {
      'USD'     => 1.09,
      'Bitcoin' => 0.00084,
      'GBP' => 0.85
    })
    CurrencyConverter::Money.conversion_rates('USD', {
      'EUR'     => 0.92,
      'Bitcoin' => 0.00077,
      'GBP' => 0.78
    })
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    three_usd = CurrencyConverter::Money.new(3, 'USD')
    expect(five_eur - three_usd).to eq(2.23)
  end

  it "divids itself correctly" do
    CurrencyConverter::Money.conversion_rates('EUR', {
      'USD'     => 1.09,
      'Bitcoin' => 0.00084,
      'GBP' => 0.85
    })
    five_eur = CurrencyConverter::Money.new(5, 'EUR')
    expect(five_eur * 2).to eq(10)
  end
end
