jQuery(document).bind "ready", () =>
	$("#sortable").disableSelection()
	$("#sortable").sortable {
		update: ->
				$.post($(this).data('sorting-url'), {positions: $(this).sortable('toArray')} ).error(-> 
					alert("error while processing sorting.");
					$(this).sortable("cancel");
					$(this).sortable("disable");
					)
	}