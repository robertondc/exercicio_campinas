# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(document).bind "ready", () =>
	$("#sortable").disableSelection()
	old_order = null
	$("#sortable").sortable {
	 	start: ->
				old_order = $(this).sortable('toArray')
		stop: ->
				new_order = $(this).sortable('toArray')
				$.post('/people/positions_state.json', { new_positions: new_order, old_positions: old_order } ).error(-> 
					alert("error while processing sorting.");
					$("#sortable").sortable("cancel");
					$("#sortable").sortable("disable");
					)
	}