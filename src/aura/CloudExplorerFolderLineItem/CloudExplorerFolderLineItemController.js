({
	downloadItem : function(component, event, helper) {
		helper.getDownloadLink(component);
	},

	renameItem : function(component, event, helper) {
		helper.renameStorageItem(component, event);
	}
})