<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.utp.visitas.model.*" %>
<% Promotor p = (Promotor) request.getAttribute("promotor"); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignación de Cartera</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
    <div class="container bg-white p-4 rounded shadow-sm">
        <h4 class="fw-bold text-danger">Asignar Colegios a: <%= p.getNombres() %> <%= p.getApellidos() %></h4>
        
        <!-- RUTA CORREGIDA CON CONTEXT PATH -->
        <form action="${pageContext.request.contextPath}/SupervisorController" method="POST">
            <input type="hidden" name="accion" value="guardarAsignacion">
            <input type="hidden" name="idPromotor" value="<%= p.getIdPromotor() %>">
            
            <table class="table mt-4">
                <thead>
                    <tr><th>Seleccionar</th><th>Nombre del Colegio</th><th>Distrito</th><th>Prioridad</th></tr>
                </thead>
                <tbody>
                    <% 
                        List<Instituto> libres = (List<Instituto>) request.getAttribute("listaColegios");
                        if (libres != null && !libres.isEmpty()) {
                            for(Instituto inst : libres) { 
                    %>
                                <tr>
                                    <td><input type="checkbox" name="idColegios" value="<%= inst.getIdInstituto() %>"></td>
                                    <td><%= inst.getNombreInstituto() %></td>
                                    <td><%= inst.getDistrito() %></td>
                                    <td><span class="badge bg-warning"><%= inst.getPrioridad() %></span></td>
                                </tr>
                    <%      } 
                        } else { 
                    %>
                                <tr>
                                    <td colspan="4" class="text-center">
                                        <div class="alert alert-warning">
                                            No hay colegios libres disponibles. 
                                            <!-- RUTA CORREGIDA HACIA EL CONTROLADOR -->
                                            <a href="${pageContext.request.contextPath}/SupervisorController?accion=verColegios" class="btn btn-sm btn-outline-danger ms-2">Ir a registrar colegios</a>
                                        </div>
                                    </td>
                                </tr>
                    <%  } %>
                </tbody>
            </table>
            <button type="submit" class="btn btn-danger">Confirmar Asignación</button>
            
            <!-- RUTA DEL BOTÓN CANCELAR CORREGIDA -->
            <a href="${pageContext.request.contextPath}/SupervisorController?accion=verPersonal" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>