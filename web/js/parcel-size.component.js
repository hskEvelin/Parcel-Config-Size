// Register `phoneList` component, along with its associated controller and template
angular.
  module('parcelConfig').
  component('parcelSize', {
	  transclude: true,
	  template:
		  '<div class="w3-card-4">'+
		  '<div class="w3-container w3-green">'+
		    '<h2>Paketgröße</h2>'+
		  '</div>'+

		  '<form class="w3-container">'+
	
		  '<label>Länge</label>'+
		  '<input class="w3-input" type="text" ng-model="$ctrl.parcel.length">'+
	
		  '<label>Breite</label>'+
		  '<input class="w3-input" type="text" ng-model="$ctrl.parcel.height">'+
		 
		  '<label>Tiefe</label>'+
		  '<input class="w3-input" type="text" ng-model="$ctrl.parcel.depth">'+
		  '</form>'+
	
		  '</div>' ,
    	
    	
    controller: function ParcelOptionController($rootScope) {
      this.size = 
        {
          length: 0,
          height: 0,
          depth: 0
        };
      $rootScope.size = this.size;
    }
  });
  
 
  