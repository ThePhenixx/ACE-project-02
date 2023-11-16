<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <title>Add Vehicles</title>
    <script>
        $(document).ready(function() {
            // Fetch and populate the dropdown options on page load
            $.ajax({
                url: 'VehiculeController?action=getTrackers',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var options = '<option value="0">None</option>';
                    $.each(data, function(index, tracker) {
                        options += '<option value="' + tracker.id + '">' + tracker.simNumber + '</option>';
                    });
                    $('#trackerDropdown').html(options);
                }
            });
        });
    </script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <main class="flex justify-center mt-20">
        <div class="bg-slate-100 px-16 rounded-lg">
            <div class="pt-10">
                <h1 class="text-gray-600 font-bold text-2xl underline">Create Vehicle:</h1>
            </div>
            <div class="pt-6">
                <form action="VehiculeController">
                    <div class="py-4">
                        <input type="text" name="matricule" placeholder="Matricule" class="h-8 pl-4 w-72 rounded-md"/>
                    </div>
                    <div class="pb-4">
                        <select id="trackerDropdown" name="tracker" class="h-8 w-64 pl-4 rounded-md">
                        </select>
                        <button type="button" onclick="redirectToAddTracker()" class="w-8 bg-white h-8 font-bold rounded-md">+</button>
                        <script>
						    function redirectToAddTracker() {
						        window.location.href = '/TrackerWeb/addTracker.jsp';
						    }
						</script>
                    </div>
                    <div class="flex justify-center pt-2 pb-10">
                        <button class="bg-blue-500 h-10 w-60 text-white rounded">Add Vehicle</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
