<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<script src="https://cdn.tailwindcss.com"></script>
 	<title>Header</title>
</head>
<body>
	<header class="flex justify-between items-center text-lg h-14 bg-teal-500 text-white">
        <div class="px-8 text-2xl cursor-pointer">
            <a href="${indes.jsp}">Logo</a>
        </div>
        <div>
            <ul class="flex">
                <li class="px-4 mx-2 cursor-pointer">
                	<c:url var="Url" value="/index.jsp" />
                	<a href="${Url}">Vehicules</a>
                </li>
                <li class="px-4 ml-2 cursor-pointer  mr-6">
                	<c:url var="trackersUrl" value="/trackers.jsp" />
                	<a href="${trackersUrl}">Trackers</a>
                </li>
            </ul>
        </div>
    </header>
</body>
</html>