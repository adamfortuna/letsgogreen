class AmountCalculator
  def self.amount_for_time_period(relation, start_date, end_date)
    relation.where(date: start_date..end_date).sum(:amount)
  end
end