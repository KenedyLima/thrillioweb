package thrillio.project.controllers;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Collection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import thrillio.project.constants.KidFriendlyStatus;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.User;
import thrillio.project.managers.BookmarkManager;

@WebServlet(urlPatterns = { "/bookmark", "/bookmark/mybooks", "/bookmark/save" })
public class BookmarkController extends HttpServlet {
	/*
	 * private BookmarkController() {}
	 * 
	 * private static BookmarkController instance = new BookmarkController();
	 * 
	 * public static BookmarkController getInstance() { return instance; }
	 */

	public BookmarkController() {
	};

	public void saveUserBookmark(User user, Bookmark bookmark) throws MalformedURLException, URISyntaxException {
		BookmarkManager.saveUserBookmark(user, bookmark);
	}

	public void setKidFriendlyStatus(User user, KidFriendlyStatus kidFriendlyStatusDecision, Bookmark bookmark) {
		// System.out.println("setKidFriendlyStatus - BookmarkController");
		BookmarkManager.getInstance().setKidFriendlyStatus(user, kidFriendlyStatusDecision, bookmark);

	}

	public void share(User user, Bookmark bookmark) {
		BookmarkManager.getInstance().share(user, bookmark);

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.print("BookmarkController request.getServletPath(): " + request.getServletPath());

		if (request.getSession().getAttribute("userId") != null) {
			long userId = (long) request.getSession().getAttribute("userId");

			if (request.getServletPath().contains("mybooks")) {
				Collection<Bookmark> books = BookmarkManager.getInstance().getBooks(true, userId);
				System.out.println("\nmyBooks: " + books);
				// System.out.println("\nBookmarkController: " + userId);
				request.setAttribute("books", books);
				request.getRequestDispatcher("/MyBooks.jsp").forward(request, response);

			} else if (request.getContextPath().contains("save")) {

			} else {
				Collection<Bookmark> list = BookmarkManager.getInstance().getBooks(false, userId);
				System.out.println("LIST: " + list);
				request.setAttribute("books", list);
				request.getRequestDispatcher("/Browse.jsp").forward(request, response);
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