module BillsHelper
  def name_for_bill(bill)
    bill.title.blank? ? bill.payee : bill.title
  end
end
