module Scheduleable
  module InstanceMethods

    def monthly?
      schedule == "Monthly"
    end

    def yearly?
      schedule == "Yearly"
    end

    def monthly_amount
      if monthly?
        amount
      elsif yearly?
        amount/12
      else
        amount
      end
    end

    def yearly_amount
      if yearly?
        amount
      elsif monthly?
        amount * 12
      else
        amount
      end
    end
  end
end