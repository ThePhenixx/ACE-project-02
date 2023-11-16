<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Include jQuery library -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <title>Vehicules List</title>
    
    <script>
	    $(document).ready(function() {
	        // Fetch and populate the vehicules list on page load
	        $.ajax({
	            url: 'VehiculeController?action=getVehicules',
	            type: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                var rows = '<tr>'+
	                    '<th class="w-60 border border-slate-300">Identification Number</th>'+
	                    '<th class="w-60 border border-slate-300">Matricule</th>'+
	                    '<th class="w-60 border border-slate-300">Tracker en Cours</th>'+
	                    '<th class="w-60 border border-slate-300">Date debut</th>'+
	                '</tr>';
	                $.each(data, function(index, vehicule) {
	                    // Replace property names with actual ones from your Vehicule entity
	                    rows += '<tr id="' + vehicule.id + '" onclick="navigateToUpdatePage(\'' + vehicule.id + '\')">' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.id + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.matricule + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.tracker + '</td>' +
	                            '<td class="w-60 border border-slate-300">' + vehicule.dateDebut + '</td>' +
	                            '</tr>';
	                });
	                $('#vehiculesList').html(rows);
	            }
	        });
	    });
	
	    function navigateToUpdatePage(vehicleId) {
	        // Redirect to the updateVehicle.jsp page with the vehicle ID
	        window.location.href = '<%= request.getContextPath() %>/vehiculeUpdate.jsp?id=' + vehicleId;
	    }
	</script>

</head>
<body>

    <jsp:include page="header.jsp" />
    
    <main class="flex justify-center mt-10">
        <div>
            <div class="text-gray-600 font-bold text-2xl underline">
                Vehicules List:
            </div>
    
            <div class="mt-4">
                <table id="vehiculesList" class="border-separate border-spacing-1 border border-slate-400 text-center">
                </table>
            </div>
        </div>
    </main>
</body>
</html>
