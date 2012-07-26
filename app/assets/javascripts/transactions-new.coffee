$ ->
  $("input[name='transaction[type]']").change (e) ->
    console.log($(this).val())
    categories = $("#transaction_category_id")
    categories.find("optgroup").attr('disabled', 'disabled')
    id = $(this).attr("id")
    if id == "transaction_type_savings"
      categories.find("optgroup[label='Savings']").removeAttr('disabled')
    else if id == "transaction_type_debit"
      categories.find("optgroup[label='Bills'], optgroup[label='Monthly Budgets'], optgroup[label='Yearly Budgets']").removeAttr('disabled')
    else if id == "transaction_type_credit"
      categories.find("optgroup[label='Incomes']").removeAttr('disabled')

  $("input[name='transaction[type]']").trigger('change')