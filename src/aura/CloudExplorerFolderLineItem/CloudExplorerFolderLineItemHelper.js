({
	getDownloadLink : function(component) {
		var action = component.get("c.CloudStorageController");
		action.setParams({
			'storageItemId': component.get(storageItem.Id)
		});

		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === "SUCCESS") {
            	component.set('v.downloadLink', response.getReturnValue());
        	}
		});

		$A.enqueueAction(action);
	},

	renameStorageItem : function(component, event) {
		
	}

})