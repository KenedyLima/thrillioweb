
package thrillio.project.controllers;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import thrillio.project.managers.UserManager;

@WebServlet(urlPatterns = { "/auth", "/auth/logout" })
public class AuthController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		if (!request.getServletPath().contains("logout")) {
			String email = request.getParameter("email");
			
			String password = request.getParameter("password");
			long userId = UserManager.getInstance().authenticate(email, password);
			
			if (userId != -1) {

				HttpSession session = request.getSession();
				session.setAttribute("userId", userId);
				request.getRequestDispatcher("bookmark/mybooks").forward(request, response);

			} else {
				request.getRequestDispatcher("/Login.jsp").forward(request, response);
			}
		} else {
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
		}



	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
