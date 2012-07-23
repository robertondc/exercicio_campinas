# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(document).bind "ready", () =>
	$("#sortable").disableSelection()
	$("#sortable").sortable { 
		stop: ->
				ui_order = $(this).sortable('toArray')
				$.post('/people/positions_state.json', { positions: ui_order} ).error(-> alert("error while processing sorting.") )
	}