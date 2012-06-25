$ ->
  $("table.expenses a.expand").click (e) ->
    $(this).parents("tbody").next().toggle()
    return false
