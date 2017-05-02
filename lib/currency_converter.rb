require "currency_converter/version"
module CurrencyConverter
  class Money
    attr_reader :amount, :currency
    @@conversion_rates = {}

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
    end

    def inspect
      "#{@amount} #{@currency}"
    end

    # def +(x)
    #   @amount + amazing_helper_method(x)
    # end
    #
    # def -(x)
    #   @amount - amazing_helper_method(x)
    # end
    #
    # def *(x)
    #   @amount * amazing_helper_method(x)
    # end
    [:+, :-, :*, :'==', :/, :<, :>, :<=, :>=, :%].each do |meth|
      define_method(meth) do |other|
        @amount.send(meth, is_it_money_object(other))
      end
    end

    def is_it_money_object(x)
      if x.is_a?(CurrencyConverter::Money)
        # perform conversion
        x.convert_to(@currency)
      else
        x #assume we have a number already
      end
    end

    def self.conversion_rates(currency, rates={})
      @@conversion_rates[currency] = {currency => 1}.merge(rates)
    end

    #add a test for this
    def convert_to(currency)
      @amount * rates[currency]
    end

    def rates
      @@conversion_rates[@currency]
    end
  end
end
#
CurrencyConverter::Money.conversion_rates('EUR', {
  'USD'     => 1.09,
  'Bitcoin' => 0.00084,
  'GBP' => 0.85
})
#
CurrencyConverter::Money.conversion_rates('USD', {
  'EUR'     => 0.92,
  'Bitcoin' => 0.00077,
  'GBP' => 0.78
})
#
CurrencyConverter::Money.conversion_rates('GBP', {
  'EUR'     => 1.18,
  'Bitcoin' => 0.00099,
  'USD' => 1.29
})
#
# # TODO remove
# five_eur = CurrencyConverter::Money.new(5, 'EUR')
# ten_eur = CurrencyConverter::Money.new(10, 'EUR')
# five_usd = CurrencyConverter::Money.new(5, 'USD')
# five_gbp = CurrencyConverter::Money.new(5, 'GBP')
#
# puts five_eur.convert_to('USD')
# puts ten_eur + five_usd
# puts ten_eur - five_usd
# puts ten_eur == five_usd
# puts ten_eur + 2
# puts five_usd + five_gbp
# puts five_gbp + five_usd
