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
    <title>Trackers List</title>

    <script>
        $(document).ready(function() {
            // Fetch and populate the dropdown options on page load
            $.ajax({
                url: 'TrackerController?action=getTrackers',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var rows = '<tr>'+
                        '<th class="w-60 border border-slate-300">Identification Number</th>'+
                        '<th class="w-72 border border-slate-300">Sim Number</th>'+
                        '<th class="w-72 border border-slate-300">Delete</th>'+
                    '</tr>';
                    $.each(data, function(index, tracker) {
                        if (tracker.inUse == false) {
                            rows += '<tr id="' + tracker.id + '">' +
                                '<td class="w-60 border border-slate-300">' + tracker.id + '</td>' +
                                '<td class="w-60 border border-slate-300">' + tracker.simNumber + '</td>' +
                                '<td class="w-60 border bg-red-100"><button class="w-72" onclick="confirmDelete(\'' + tracker.id + '\')">Delete</button></td>' +
                                '</tr>';
                        } else {
                            rows += '<tr id="' + tracker.id + '">' +
                                '<td class="w-60 border border-slate-300">' + tracker.id + '</td>' +
                                '<td class="w-60 border border-slate-300">' + tracker.simNumber + '</td>' +
                                '<td class="w-60 border bg-green-100"><button class="w-72">In Use</button></td>' +
                                '</tr>';
                        }
                    });

                    $('#trackersList').html(rows);
                }
            });
        });

        function confirmDelete(trackerId) {
            // Display a confirmation dialog
            var isConfirmed = confirm('Are you sure you want to delete this tracker?');

            if (isConfirmed) {
                $.ajax({
                    url: 'TrackerController?action=deleteTracker&id=' + trackerId,
                    type: 'POST',
                    success: function(response) {
                        location.reload();
                    }
                });
            }
        }
    </script>
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="flex justify-center mt-10">
        <div>
            <div class="text-gray-600 font-bold text-2xl underline">
                Trackers List:
            </div>

            <div class="mt-4">
                <table id="trackersList" class="border-separate border-spacing-1 border border-slate-400 text-center">
                </table>
            </div>
        </div>
    </main>

</body>
</html>
