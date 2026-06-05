package com.utp.visitas.controller;

import com.utp.visitas.dao.UsuarioDAO;
import com.utp.visitas.model.Usuario;
import com.google.common.base.Strings;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recibir parámetros del formulario login.html
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        // 2. Validación de seguridad usando Google Guava (Evita NullPointerExceptions)
        if (Strings.isNullOrEmpty(correo) || Strings.isNullOrEmpty(contrasena)) {
            response.sendRedirect("login.html?error=vacios");
            return;
        }

        // 3. Consultar la base de datos a través del DAO
        Usuario usuarioValidado = usuarioDAO.validarLogin(correo, contrasena);

        if (usuarioValidado != null) {
            // 4. Crear sesión HTTP para mantener al usuario conectado
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuarioValidado);

            // 5. Redirección inteligente basada en el Rol
            if (usuarioValidado.getRol().equals("Supervisor")) {
                response.sendRedirect("supervisor/dashboard_supervisor.jsp");
            } else {
                // Ahora redirige al Servlet para que cargue la base de datos primero
                response.sendRedirect("promotor/inicio_promotor.jsp");
            }
        } else {
            // Credenciales incorrectas, volver al login
            response.sendRedirect("login.html?error=credenciales");
        }
    }
}