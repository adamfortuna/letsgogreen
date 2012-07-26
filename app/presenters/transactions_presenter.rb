require 'delegate'

class TransactionsPresenter < SimpleDelegator
  attr_reader :controller

  attr_accessor :transactions, :options

  def initialize(controller, transactions, options={})
    @controller = controller
    @options = options
    @transactions = transactions
  end

  def title
    if options[:title]
      "Transactions - #{options[:title]}"
    else
      "Transactions"
    end
  end
end