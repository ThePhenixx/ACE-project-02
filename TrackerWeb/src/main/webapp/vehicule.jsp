<%@page import="entities.Vehicule"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<form action="VehiculeController">
		Matricule : <input type="text" name="matricule"><br />
		<button>Envoyer</button>
	</form>

	<ul>
        <c:forEach items="${vehicules}" var="v" >
            <li>${v.id} - ${v.matricule}</li>
        </c:forEach>
    </ul>
</body>
</html>