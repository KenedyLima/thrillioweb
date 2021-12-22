
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

		System.out.print("request.getServletPath()" + request.getServletPath());
		
		if (!request.getServletPath().contains("logout")) {
			System.out.println("CONTAINS LOGOUT");
			String email = request.getParameter("email");
			System.out.println(email);
			
			String password = request.getParameter("password");
			System.out.println("PASSWORDDDDDDDDDDDD: " + password);
			long userId = UserManager.getInstance().authenticate(email, password);
			System.out.println("AuthController - USER IDddddd : " + userId);

			if (userId != -1) {

				HttpSession session = request.getSession();
				session.setAttribute("userId", userId);
				System.out.println("SESSION WAS INITIATED");
				request.getRequestDispatcher("bookmark/mybooks").forward(request, response);

			} else {
				request.getRequestDispatcher("/Login.jsp").forward(request, response);
			}
		} else {
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
		}

		// dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
