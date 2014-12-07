# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

changeCost = ->
  console.log("changeCost")

  partsCost = Number($('#total-parts-cost').text().replace(/[^0-9\.]+/g,""));
  laborCost = Number($('#repair_labor_cost').val())

  totalCost = partsCost + laborCost
  $('#repair_total_cost').val(totalCost)

$(document).on 'change', '#repair_labor_cost', ->
  console.log("labor cost change")
  changeCost()


#########################################
# Init
#########################################

$(document).on 'ready', ->
  changeCost()
