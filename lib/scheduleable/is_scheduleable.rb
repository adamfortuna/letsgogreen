module Scheduleable
  class << ActiveRecord::Base
    def is_scheduleable options = {}
      cattr_accessor :schedules
      self.schedules = %w(Monthly Yearly) || options[:schedules]

      attr_accessible :amount, :schedule

      validates :amount, presence: true

      self.schedules.each do |schedule|
        send :scope, schedule.downcase.to_sym, where(schedule: schedule)
      end

      include Scheduleable::InstanceMethods
      extend Scheduleable::ClassMethods
    end
  end
end