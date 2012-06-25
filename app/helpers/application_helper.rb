module ApplicationHelper

  def accountables_for(user)
    monthly_budgets = user.budgets.monthly.order(:title).collect do |budget|
      ["#{budget.title} (#{number_to_currency(budget.amount)})", "Budget-#{budget.id}"]
    end

    yearly_budgets = user.budgets.yearly.order(:title).collect do |budget|
      ["#{budget.title} (#{number_to_currency(budget.amount)})", "Budget-#{budget.id}"]
    end

    bills = user.bills.order(:title).collect do |bill|
      ["#{name_for_bill(bill)} (#{number_to_currency(bill.amount)})", "Bill-#{bill.id}"]
    end

    { 
      'Monthly Budgets' => monthly_budgets,
      'Yearly Budgets' => yearly_budgets,
      'Bills' => bills
    }
  end
end
