// Register `phoneList` component, along with its associated controller and template
angular.
  module('parcelConfig').
  component('parcelSize', {
	  transclude: true,
	  template:
		  '<div class="w3-card-4">'+
		  '<div class="w3-container w3-teal">'+
		    '<h2>Paketgröße</h2>'+
		  '</div>'+

		  '<form class="w3-container">'+
	
		  '<label>Länge</label>'+
		  '<input class="w3-input" id="cfg-size-length" type="text" ng-model="$ctrl.parcel.length">'+
	
		  '<label>Breite</label>'+
		  '<input class="w3-input" id="cfg-size-height" type="text" ng-model="$ctrl.parcel.height">'+
		 
		  '<label>Tiefe</label>'+
		  '<input class="w3-input" id="cfg-size-depth" type="text" ng-model="$ctrl.parcel.depth">'+
		  '</form>'+
		  '<br />'+
		  '<button id="cfg-size-button" class="w3-btn w3-cyan" ng-click="$ctrl.calcSize($ctrl.parcel)">Größe berechnen</button><label id="cfg-size-res">Paketgröße: {{$ctrl.parcel.size}}</label> '+
		  '</div>' ,
    	
    	
    controller: function ParcelOptionController($rootScope, $http) {
      this.parcel = 
        {
          length: 0,
          height: 0,
          depth: 0,
          size: ''
        };
      $rootScope.size = this.size;
      this.parcelsize = '';
      this.calcSize = function($parcel){
    	 console.log(JSON.stringify(this.parcel));
    	
    	 $http({
    		    url: "http://vm.parcel.aps.com:1100/parcel/sent/size",
    		    dataType: "json",
    		    method: "POST",
    		    data: JSON.stringify(this.parcel),
    		    headers: {
    		        "Content-Type": "text/plain"
    		    }
    		}).then(function(response){
    			console.log(response.data.size);
    			$parcel.size = response.data.size;
    		});
    	 
      }
    }
  });
  
 
  