<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <title>Vehicules update</title>
    
    <script>
	    function redirectToAddTracker() {
	        window.location.href = '/TrackerWeb/addTracker.jsp';
	    }
	    function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }
        var vehiculeId = getParameterByName('id');
    	var Id;
    	var TrackerId;
        $(document).ready(function() {
        	
        	var options = '';
        	
            // Fetch and populate the dropdown options on page load
            $.ajax({
                url: 'VehiculeController?action=getTrackers',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(index, tracker) {
                        options += '<option value="' + tracker.id + '">' + tracker.simNumber + '</option>';
                    });
                    $('#dropDownList').html(options);
                }
            });
            
            $.ajax({
	            url: 'VehiculeController?action=getHistory&id='+vehiculeId,
	            type: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                var rows = '<tr>'+
	                    '<th class="w-60 border border-slate-300">Identification Number</th>'+
	                    '<th class="w-60 border border-slate-300">Matricule</th>'+
	                    '<th class="w-60 border border-slate-300">Tracker Sim Number</th>'+
	                    '<th class="w-60 border border-slate-300">Date debut</th>'+
	                    '<th class="w-60 border border-slate-300">Date fin</th>'+
	                '</tr>';
	                $.each(data, function(index, vehicule) {
	                    // Replace property names with actual ones from your Vehicule entity
	                    rows += '<tr id="' + vehicule.id + '" onclick="navigateToUpdatePage(\'' + vehicule.id + '\')">' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.id + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.matricule + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.simNumber + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.dateDebut + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.dateFin + '</td>' +
	                            '</tr>';
	                });
	                $('#historicTable').html(rows);
	            }
	        });
            
            function getParameterByName(name, url) {
                if (!url) url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }
            
            var vehicleId = getParameterByName('id');
            $.ajax({
                url: 'VehiculeController?action=getVehicule&id=' + vehicleId,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var code = '';
                    var firstElement = false;
                    $.each(data, function(index, vehicule) {
                        if(!firstElement){
                        	Id = vehicule.id;
                        	TrackerId = vehicule.trackerId;
                        	if (vehicule.simNumber == "none") {
                            	code += '<div class="py-4">' +
                                '<input type="text" name="matricule" value="' + vehicule.matricule + '" class="h-8 pl-4 w-72 rounded-md"/>' +
                                '</div>' +
                                '<div class="pb-4">' +
                                '<select name="tracker" class="h-8 w-64 pl-3 mr-1 rounded-lg">' +
                                '<option value="0">None</option>'+
                                options+
                                '</select>' +
                                '<button onClick="redirectToAddTracker()" class="w-7 bg-white h-8 font-bold rounded-lg">+</button>' +
                                '</div>';
                            } else {
                                code += '<div class="py-4">' +
                                    '<input type="text" name="matricule" value="' + vehicule.matricule + '" class="h-8 pl-4 w-72 rounded-md"/>' +
                                    '</div>' +
                                    '<div class="pb-4">' +
                                    '<div name="tracker" class="h-8 w-64 pl-4 bg-white rounded-lg w-72">' +
                                    '<select name="tracker" class="h-8 w-64 pl-3 mr-1 rounded-lg">' +
                                    '<option value="0">' + vehicule.simNumber + '</option>'+
                                    '</select>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div>' +
                                    '<button type="button" onclick="confirmDelete(' + vehicule.id + ')" class="bg-green-500 h-8 w-72 text-white rounded">Remove Tracker</button>'
                                    '</div>';

                            }
                        	firstElement = true;
                        }
                    });
                    $('#formContent').html(code);
                }
            });
        });
        
        function confirmDelete(id) {
            // Display a confirmation dialog
            var isConfirmed = confirm('Are you sure you want to remove this tracker?');

            if (isConfirmed) {
                $.ajax({
                    url: 'VehiculeController?action=removeTracker&id=' + id, 
                    type: 'POST',
                });
            }
        }
        
        function updateClick() {
            var newMatricule = $('input[name="matricule"]').val();
            var newTrackerId = $('select[name="tracker"]').val();

            var params = '&id='+vehiculeId+'&matricule='+newMatricule+'&trackerId='+newTrackerId;

            var isConfirmed = confirm('Are you sure you want to update this vehicule?');

            if (isConfirmed) {
                $.ajax({
                    url: 'VehiculeController?action=updateVehicule'+params,
                    type: 'POST',
                    contentType: 'application/json',
                    success: function (response) {
                        location.reload();
                    }
                });
            }
        }


        
        function deleteClick(){
        	 var isConfirmed = confirm('Are you sure you want to delete this vehicule?');

             if (isConfirmed) {
                 $.ajax({
                     url: 'VehiculeController?action=deleteVehicule&id=' + vehiculeId, 
                     type: 'POST',
                     contentType: 'application/json',
                     
                 });
                 window.location.href = '/TrackerWeb/vehiculesList.jsp';
             }
        }
	    
	</script>

 
</head>
<body>

    <jsp:include page="header.jsp" />
    
    <main>

        <div class="flex justify-center mt-10 ">

            <div class=" bg-slate-100 px-16 pb-8 rounded-lg">

                <div class="pt-10">
                    <h1 class="text-gray-600 font-bold text-2xl underline">
                        Update Vehicule:
                    </h1>
                </div>
        
                <div class="flex justify-between pt-6">
                    <form id="formContent" action="">
                    </form>
                    <div class="ml-10">
                        <div class="py-4">
                            <button onClick="updateClick()" class="bg-blue-500 h-8 w-60 text-white rounded">Update Vehicule</button>
                        </div>
                        <div>
                            <button onClick="deleteClick()" class="bg-red-500 h-8 w-60 text-white rounded">Delete Vehicule</button>
                        </div>
                    </div>
                <div>

            </div>
            </div>
            </div>
        </div>

        <div>
            <div class="flex justify-center pt-10">
                <h1 class="text-gray-600 font-bold text-2xl underline">
                    Vehicule History:
                </h1>
            </div>
            <div class="flex justify-center  mt-4">
                <table id="historicTable" class="border-separate border-spacing-1 border border-slate-400 text-center">
                  </table>
            </div>
        </div>

    </main>

</body>
</html>