defmodule SalesTax do
  @tax_rates [ NC: 0.075, TX: 0.08 ]
  
  def process(orders) do
    for order <- orders do 
      total = add_tax(order, @tax_rates)
      order ++ [total_amount: total]
    end
  end

  def add_tax(order, tax_rates) do
    ship_to = Keyword.get(order, :ship_to)
    net     = Keyword.get(order, :net_amount)
    
    rate = 
      case ship_to do
        :TX -> Keyword.get(tax_rates, :TX, 0)
        :NC -> Keyword.get(tax_rates, :NC, 0)
        _   -> 0
      end
    
    net * (1 + rate)
  end
end
