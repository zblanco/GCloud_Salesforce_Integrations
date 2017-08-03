({
	toggleCheckbox : function(component, event, helper) {
		boxState = component.get("v.checkboxState");
		boxState = !boxState;
		console.log('setting selectAllCheckbox as ' + boxState);
		component.set("v.checkboxState", boxState);
	},

	handleBoxChange : function(component, event, helper) {
		var boxState = component.get("v.checkboxState");
		var selectAllEvent = component.getEvent("SelectAllEvent");

		console.log("Firing selectAllEvent! params:: " + "state=" + boxState);
		
		selectAllEvent.setParams({"state" : boxState});
		selectAllEvent.fire();
	}
})