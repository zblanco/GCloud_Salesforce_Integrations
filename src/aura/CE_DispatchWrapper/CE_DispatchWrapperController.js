({
	doInit : function(component, event, helper) {
		helper.getStorageItems(component);
	},

	initSelectionState : function(component, event, helper) {
		helper.setSelectionState(component);
	},

	handleFilesChange : function(component, event, helper) {
		console.log("~handleFilesChange~");
	},

	handleSelectionChange : function(component, event, helper) {
		helper.updateSelectionState(component, event, helper)
	}
})