jQuery(document).bind "ready", () =>
	$("#sortable").disableSelection()
	$("#sortable").sortable {
		update: (event, ui) ->
				$.post(ui.item.data('sort-path'), {position: ui.item.index()} ).error(-> 
					alert("error while processing sorting.");
					$(this).sortable("cancel");
					$(this).sortable("disable");
					)
	}