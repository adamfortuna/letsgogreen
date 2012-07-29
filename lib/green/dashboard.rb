class Dashboard
  attr_accessor :start_date, :end_date

  def initialize(options = {})
    @start_date = options[:start_date] || Date.today.beginning_of_month
    @end_date = options[:end_date] || Date.today.end_of_month + 1.day
    @user = options[:user]
  end

  def start_year
    @start_date.beginning_of_year
  end

  def end_year
    @start_date.end_of_year
  end


  def months_with_expenses
    @user.credits.select("date_part('month', date) AS month, date_part('year', date) AS year").group("date_part('month', date), date_part('year', date)").collect do |expense|
      Date.strptime "#{expense.month}/1/#{expense.year}", '%m/%d/%Y'
    end.sort.reverse
  end

  def percent_of_income(amount)
    amount / yearly_income * 100
  end


  def incomes
    @incomes ||= @user.incomes.order(:title)
  end
  def monthly_income_estimate
    @monthly_income_estimate ||= incomes.inject(0) { |total, i| total + i.monthly_amount } 
  end
  def monthly_income_amount
    @monthly_income ||= @user.credits.where(date: @start_date..@end_date).sum(:amount)
  end

  def monthly_income_for(income)
    @monthly_income_for ||= {}
    @monthly_income_for[income.id] ||= income.transactions.where(date: @start_date..@end_date).sum(:amount)
  end



  def savings
    @savings ||= @user.savings.order(:title)
  end
  def monthly_savings_estimate
    @monthly_savings_estimate ||= savings.inject(0) { |total, i| total + i.monthly_amount }  * -1
  end
  def monthly_savings_amount
    @monthly_savings_amount ||=  savings.collect { |s| monthly_savings_for(s) }.sum * -1
  end
  def monthly_savings_for(saving)
    @monthly_savings_for ||= {}
    @monthly_savings_for[saving.id] ||= if saving.monthly?
      saving.transactions.savings.where(date: @start_date..@end_date).sum(:amount)
    else
      saving.transactions.savings.where(date: @start_date.beginning_of_year..@end_date.end_of_year).sum(:amount) / 12
    end
  end



  def monthly_bills
    @monthly_bills ||= @user.bills.monthly.order("amount desc")
  end
  def monthly_bills_estimate
    @monthly_bills_estimate ||= monthly_bills.inject(0) { |total, i| total + i.monthly_amount }  * -1
  end
  def monthly_bills_amount
    @monthly_bills_amount ||= monthly_bills.collect { |s| monthly_bills_for(s) }.sum * -1
  end
  def monthly_bills_for(bill)
    @monthly_bills_for ||= {}
    @monthly_bills_for[bill.id] ||= if bill.monthly?
      bill.transactions.bills.where(date: @start_date..@end_date).sum(:amount)
    else
      bill.transactions.bills.where(date: @start_date.beginning_of_year..@end_date.end_of_year).sum(:amount) / 12
    end
  end



  def monthly_budgets
    @monthly_budgets ||= @user.budgets.monthly.order(:title)
  end
  def monthly_budgets_estimate
    @monthly_budgets_estimate ||= monthly_budgets.inject(0) { |total, i| total + i.monthly_amount }  * -1
  end
  def monthly_budgets_amount
    @monthly_budgets_amount ||= monthly_budgets.collect { |s| monthly_budgets_for(s) }.sum * -1
  end
  def monthly_budgets_for(budget)
    @monthly_budgets_for ||= {}
    @monthly_budgets_for[budget.id] ||= if budget.monthly?
      budget.transactions.budgets.where(date: @start_date..@end_date).sum(:amount)
    else
      budget.transactions.budgets.where(date: @start_date.beginning_of_year..@end_date.end_of_year).sum(:amount) / 12
    end
  end

  def yearly_budgets
    @yearly_budgets ||= @user.budgets.yearly.order(:title)
  end
  def yearly_budgets_estimate
    @yearly_budgets_estimate ||= yearly_budgets.inject(0) { |total, i| total + i.yearly_amount }  * -1
  end
  def yearly_budgets_estimate_per_month
    yearly_budgets_estimate / 12.0
  end
  def yearly_budgets_amount
    @yearly_budgets_amount ||= yearly_budgets.collect { |s| yearly_budgets_for(s) }.sum * -1
  end
  def yearly_budgets_amount_per_month
    yearly_budgets_amount / 12.0
  end
  def yearly_budgets_for(budget)
    @yearly_budgets_for ||= {}
    @yearly_budgets_for[budget.id] ||= if budget.monthly?
      budget.transactions.budgets.where(date: @start_date..@end_date).sum(:amount) * 12
    else
      budget.transactions.budgets.where(date: @start_date.beginning_of_year..@end_date.end_of_year).sum(:amount)
    end
  end



  def yearly_bills
    @yearly_bills ||= @user.bills.yearly.order(:title)
  end
  def yearly_bills_estimate
    @yearly_bills_estimate ||= yearly_bills.inject(0) { |total, i| total + i.yearly_amount }  * -1
  end
  def yearly_bills_estimate_per_month
    yearly_bills_estimate / 12.0
  end
  def yearly_bills_amount
    @yearly_bills_amount ||= yearly_bills.collect { |s| yearly_bills_for(s) }.sum * -1
  end
  def yearly_bills_amount_per_month
    yearly_bills_amount / 12.0
  end
  def yearly_bills_for(bill)
    @yearly_bills_for ||= {}
    @yearly_bills_for[bill.id] ||= if bill.monthly?
      bill.transactions.bills.where(date: @start_date..@end_date).sum(:amount) * 12
    else
      bill.transactions.bills.where(date: @start_date.beginning_of_year..@end_date.end_of_year).sum(:amount)
    end
  end

  # def yearly_bills
  #   @yearly_bills ||= @user.bills.yearly.order("amount desc")
  # end
  # def yearly_bills_amount_monthly
  #   @yearly_bills_amount_monthly ||= yearly_bills_amount / 12
  # end
  # def yearly_bills_amount
  #   @yearly_bills_amount ||= yearly_bills.sum(:amount)
  # end
  # def yearly_bills_percentage
  #   yearly_bills_amount / yearly_income * 100
  # end



  # def monthly_budgets
  #   @budgets ||= @user.budgets.monthly
  # end
  # def monthly_budget_amount
  #   @monthly_budget_amount ||= monthly_budget_amount_per_year / 12
  # end
  # def monthly_budget_amount_per_year
  #   @monthly_budget_amount_per_year ||= monthly_budgets.collect(&:yearly_amount).sum
  # end
  

  # def yearly_budgets
  #   @yearly_budgets ||= @user.budgets.yearly
  # end
  # def yearly_budget_amount_per_month
  #   @yearly_budget_amount_per_month ||= yearly_budget_amount / 12
  # end
  # def yearly_budget_amount
  #   @yearly_budget_amount ||= yearly_budgets.collect(&:yearly_amount).sum
  # end

  def budget_total
    0
    # monthly_income_amount - monthly_savings_amount - monthly_bills_amount - yearly_bills_amount_monthly - monthly_budget_amount
  end
  def monthly_total
    5423
  end
  def yearly_total
    32423
  end

  # Monthly totals
  def monthly_estimate
    monthly_income_estimate + monthly_savings_estimate + monthly_bills_estimate + monthly_budgets_estimate + yearly_bills_estimate_per_month + yearly_budgets_estimate_per_month
  end
  def monthly_amount
    monthly_income_amount + monthly_savings_amount + monthly_bills_amount + monthly_budgets_amount + yearly_bills_estimate_per_month + yearly_budgets_estimate_per_month
  end

  # Yearly totals
  def yearly_estimate
    yearly_bills_estimate + yearly_budgets_estimate
  end
  def yearly_amount
    yearly_bills_amount + yearly_budgets_amount
  end
  def yearly_difference
    
  end
end