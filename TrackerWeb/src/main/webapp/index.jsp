<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Vehicules Homepage</title>
</head>

<body>

    <jsp:include page="vehiculesHeader.jsp" />
    
    <main class="mt-40">

        <div >
        	<div class="flex justify-center">
                <button onclick="redirectToAddVehicule()" class="h-10 w-96 bg-blue-500 rounded-lg my-2 text-white text-lg">Add Vehicule</button>
            </div>
            <div class="flex justify-center">
                <button onclick="redirectToDisplayAll()" class="h-10 w-96 bg-blue-500 rounded-lg mt-6 mb-2 text-white text-lg">Display All Vehicules</button>
            </div>
        </div>

		<script>
		    function redirectToDisplayAll() {
		        window.location.href = '/TrackerWeb/vehiculesList.jsp';
		    }
		    function redirectToAddVehicule() {
		        window.location.href = '/TrackerWeb/addVehicule.jsp';
		    }
		</script>
    </main>

</body>
</html>