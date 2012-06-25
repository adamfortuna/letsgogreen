module Scheduleable
  module InstanceMethods

    def monthly?
      schedule == "Monthly"
    end

    def yearly?
      schedule == "Yearly"
    end

    def monthly_amount
      monthly? ? amount : (amount/12)
    end

    def yearly_amount
      yearly? ? amount : (amount * 12)
    end
  end
end