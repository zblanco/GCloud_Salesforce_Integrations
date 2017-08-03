({
	getStorageItems : function(component, helper) {
		
		var getItemsAction = component.get('c.getStorageItemsDB');
		getItemsAction.setCallback(this, function(response) {
			
			var state = response.getState();
			if (component.isValid() && state === "SUCCESS") {

				var storageItems = response.getReturnValue();
				console.log("return from getStorageItemsDB:: " + JSON.stringify(storageItems));
				component.set("v.storageItems", storageItems);
				component.set("v.itemsReady", true);
			}
		});
		$A.enqueueAction(getItemsAction);
	},

	setSelectionState : function(component) {
		
		var storageItems   		 = component.get("v.storageItems");
		var itemCount 	   		 = storageItems.length;
		var isSelectionStateInit = component.get("v.isSelectionStateInit");
		var selectionState 		 = component.get("v.itemSelectionState");
		console.log("~populating selectionState Map~");
		console.log("No. of storageItems to add::" + itemCount);

		for (var i = 0; i < itemCount; i++) {
			var itemId = storageItems[i].Id;
			selectionState[itemId] = false;
			console.log("selectionState[" + itemId + "] added with value: "  + selectionState[itemId]);
		}

		component.set("v.itemSelectionState", selectionState);
		component.set("v.isSelectionStateInit", true);
	},

	updateSelectionState : function(component, event, helper) {
		
		var isSelectionStateInit = component.get("v.isSelectionStateInit");
		var checkboxState 	   	 = event.getParam("checkboxState");
		var itemId 	  	  	   	 = event.getParam("itemId");
		var itemSelectionState 	 = component.get("v.itemSelectionState");
		
		if (!isSelectionStateInit) {
			helper.setSelectionState(component);
		}

		itemSelectionState[itemId] = checkboxState;
		console.log("updateSelectionState event params:: " + "\n" +
					"from component:: " + event.getSource().getName() + "\n" +
					"selectionState:: (" + itemId + ": " + itemSelectionState[itemId]  + ")"+ "\n" + 
					"checkboxState:: " + checkboxState + "\n" + "itemId:: " + itemId);

		component.set("v.itemSelectionState", itemSelectionState);
		console.log("itemSelectionState[" + itemId + "] set as " + itemSelectionState[itemId]);
	}
})