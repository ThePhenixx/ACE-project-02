<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Trackers Homepage </title>
</head>
<body>

    <jsp:include page="trackersHeader.jsp" />
    
    <main class="mt-40">

        <div >
            <div class="flex justify-center">
                <button onclick="redirectToAddTracker()" class="h-10 w-96 bg-blue-500 rounded-lg my-2 text-white text-lg">Add Tracker</button>
            </div>
            <div class="flex justify-center">
                <button onclick="redirectToDisplayAll()" class="h-10 w-96 bg-blue-500 rounded-lg mt-6 mb-2 text-white text-lg">Trackers List</button>
            </div>
        </div>

        <script>
		    function redirectToDisplayAll() {
		        window.location.href = '/TrackerWeb/trackersList.jsp';
		    }
		    function redirectToAddTracker() {
		        window.location.href = '/TrackerWeb/addTracker.jsp';
		    }
		</script>
    </main>

</body>
</html>