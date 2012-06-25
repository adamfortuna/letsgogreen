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
    @user.expenses.select("date_part('month', date) AS month, date_part('year', date) AS year").group("date_part('month', date), date_part('year', date)").collect do |expense|
      Date.strptime "#{expense.month}/1/#{expense.year}", '%m/%d/%Y'
    end.sort.reverse
  end

  def percent_of_income(amount)
    amount / yearly_income * 100
  end

  def incomes
    @incomes ||= @user.incomes.where(date: Time.now.beginning_of_month..Time.now.end_of_month).order(:amount)
  end
  def monthly_income
    @monthly_income ||= incomes.sum(:amount)
  end
  def yearly_income
    @yearly_income ||= monthly_income * 12
  end



  def savings
    @savings ||= @user.savings.order("amount desc")
  end
  def monthly_savings_amount
    @monthly_savings_amount ||= yearly_savings_amount / 12
  end
  def yearly_savings_amount
    @yearly_savings_amount ||= savings.collect(&:yearly_amount).sum
  end
  def savings_percentage
    yearly_savings_amount / yearly_income * 100
  end




  def monthly_bills
    @monthly_bills ||= @user.bills.monthly.order("amount desc")
  end
  def monthly_bills_amount
    @monthly_bills_amount ||= monthly_bills.sum(:amount)
  end
  def monthly_bills_yearly_amount
    @monthly_bills_yearly_amount ||= monthly_bills_amount * 12
  end
  def monthly_bills_percentage
    monthly_bills_yearly_amount / yearly_income * 100
  end



  def yearly_bills
    @yearly_bills ||= @user.bills.yearly.order("amount desc")
  end
  def yearly_bills_amount_monthly
    @yearly_bills_amount_monthly ||= yearly_bills_amount / 12
  end
  def yearly_bills_amount
    @yearly_bills_amount ||= yearly_bills.sum(:amount)
  end
  def yearly_bills_percentage
    yearly_bills_amount / yearly_income * 100
  end



  def monthly_budgets
    @budgets ||= @user.budgets.monthly
  end
  def monthly_budget_amount
    @monthly_budget_amount ||= monthly_budget_amount_per_year / 12
  end
  def monthly_budget_amount_per_year
    @monthly_budget_amount_per_year ||= monthly_budgets.collect(&:yearly_amount).sum
  end
  

  def yearly_budgets
    @yearly_budgets ||= @user.budgets.yearly
  end
  def yearly_budget_amount_per_month
    @yearly_budget_amount_per_month ||= yearly_budget_amount / 12
  end
  def yearly_budget_amount
    @yearly_budget_amount ||= yearly_budgets.collect(&:yearly_amount).sum
  end

  def budget_total
    monthly_income - monthly_savings_amount - monthly_bills_amount - yearly_bills_amount_monthly - monthly_budget_amount
  end
  def monthly_total
    5423
  end
  def yearly_total
    32423
  end
end