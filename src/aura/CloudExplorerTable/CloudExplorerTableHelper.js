({
	getStorageItems : function(component) {
		var action = component.get('c.getStorageItemsDB');
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {
				console.log("return from getStorageItemsDB:: " + response.getReturnValue());
				component.set("v.storageItems", response.getReturnValue());
			}
		});
		$A.enqueueAction(action);
	}

})