module ApplicationHelper

  def categories_for(user)
    accountables_for(user)    
  end

  def accountables_for(user)
    monthly_budgets = user.budgets.monthly.order(:title).collect do |budget|
      ["#{budget.title} (#{number_to_currency(budget.amount)})", budget.id]
    end

    yearly_budgets = user.budgets.yearly.order(:title).collect do |budget|
      ["#{budget.title} (#{number_to_currency(budget.amount)})", budget.id]
    end

    bills = user.bills.order(:title).collect do |bill|
      ["#{name_for_bill(bill)} (#{number_to_currency(bill.amount)})", bill.id]
    end

    incomes = user.incomes.order(:title).collect do |income|
      ["#{income.title} (#{number_to_currency(income.amount)})", income.id]
    end

    savings = user.savings.order(:title).collect do |savings|
      ["#{savings.title} (#{number_to_currency(savings.amount)})", savings.id]
    end

    { 
      'Monthly Budgets' => monthly_budgets,
      'Yearly Budgets' => yearly_budgets,
      'Bills' => bills,
      'Incomes' => incomes,
      'Savings' => savings
    }
  end

  def credit_or_debit(amount)
    class_name = amount >= 0 ? 'credit' : 'debit'
    "<span class='#{class_name}'>#{number_to_currency(amount)}</span>"
  end
end
