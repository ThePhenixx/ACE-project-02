<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Add Vehicules</title>
</head>
<body>

    <jsp:include page="header.jsp" />
    
    <main class="flex justify-center mt-20">

        <div class="bg-slate-100 px-16 rounded-lg">

            <div class="pt-10">
                <h1 class="text-gray-600 font-bold text-2xl underline">
                    New Tracker:
                </h1>
            </div>
    
            <div class="pt-6">
                <form action="TrackerController" method="get">
                    <div class="py-4">
                        <input type="text" name="simNumber" placeholder="Sim Number" class="h-8 pl-4 w-72 rounded-md"/>
                    </div>

                    <div class="flex justify-center pt-6 pb-10">
                        <button class="bg-blue-500 h-10 w-60 text-white rounded">Add Tracker</button>
                    </div>
                </form>
            <div>

        </div>

        </div>
    </main>

</body>
</html>