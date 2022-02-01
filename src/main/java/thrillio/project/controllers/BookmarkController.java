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
import thrillio.project.entities.Book;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.User;
import thrillio.project.managers.BookmarkManager;
import thrillio.project.managers.UserManager;

@WebServlet(urlPatterns = { "/bookmark", "/bookmark/mybooks", "/bookmark/save", "/bookmark/delete"})
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
		BookmarkManager.getInstance().saveUserBookmark(user, bookmark);
	}

	public void setKidFriendlyStatus(User user, KidFriendlyStatus kidFriendlyStatusDecision, Bookmark bookmark) {
		BookmarkManager.getInstance().setKidFriendlyStatus(user, kidFriendlyStatusDecision, bookmark);

	}

	public void share(User user, Bookmark bookmark) {
		BookmarkManager.getInstance().share(user, bookmark);

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (request.getSession().getAttribute("userId") != null) {
			long userId = (long) request.getSession().getAttribute("userId");
			User user = UserManager.getInstance().getUserById(userId);
			Collection<Bookmark> books =  BookmarkManager.getInstance().getBookmarks(Book.class, false, userId);
			RequestDispatcher dispatcher = request.getRequestDispatcher("");
			
			if (request.getServletPath().contains("save")) {

				Bookmark bookmark = BookmarkManager.getInstance()
						.getBookById(Long.parseLong(request.getParameter("bid")));
				BookmarkManager.getInstance().saveUserBookmark(user, bookmark);
				books = BookmarkManager.getInstance().getBookmarks(Book.class, true, userId);
				dispatcher = request.getRequestDispatcher("/MyBooks.jsp");

			} else if (request.getServletPath().contains("delete")) {
				Bookmark bookmark = BookmarkManager.getInstance()
						.getBookById(Long.parseLong(request.getParameter("bid")));
				BookmarkManager.getInstance().deleteUserBookmark(user, bookmark);
				books = BookmarkManager.getInstance().getBookmarks(Book.class, true, userId);
				dispatcher = request.getRequestDispatcher("/MyBooks.jsp");
			}

			else if (request.getServletPath().contains("mybooks")) {
				books = BookmarkManager.getInstance().getBookmarks(Book.class, true, userId);

				dispatcher = request.getRequestDispatcher("/MyBooks.jsp");

			} else {
				books = BookmarkManager.getInstance().getBookmarks(Book.class, false, userId);
				dispatcher = request.getRequestDispatcher("/Browse.jsp");
			}
			request.setAttribute("books", books);
			dispatcher.forward(request, response);
		}

		else {
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}