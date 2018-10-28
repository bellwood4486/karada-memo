relocateByYear = ->
  yearSelection = document.getElementById 'year'
  yearSelection.addEventListener 'change', ->
    Turbolinks.visit yearSelection.value

onPageLoad 'notes#index', relocateByYear
