jQuery(document).bind "ready", () =>
	$("#sortable").disableSelection()
	old_order = null
	$("#sortable").sortable {
	 	start: ->
				old_order = $(this).sortable('toArray')
		stop: ->
				new_order = $(this).sortable('toArray')
				$.post($('#sortable').data('sorting-url'), { new_positions: new_order, old_positions: old_order } ).error(-> 
					alert("error while processing sorting.");
					$("#sortable").sortable("cancel");
					$("#sortable").sortable("disable");
					)
	}