module Scheduleable
  module ClassMethods 
    def default_schedule
      schedules.first
    end
  end
end