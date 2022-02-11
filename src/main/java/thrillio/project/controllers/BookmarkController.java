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
import thrillio.project.entities.Movie;
import thrillio.project.entities.User;
import thrillio.project.entities.Weblink;
import thrillio.project.managers.BookmarkManager;
import thrillio.project.managers.UserManager;

@WebServlet(urlPatterns = { "/browse", "/bookmark/save", "/bookmark/delete" })
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookmarks");
		
		if (request.getSession().getAttribute("userId") != null) {
			long userId = (long) request.getSession().getAttribute("userId");
			User user = UserManager.getInstance().getUserById(userId);

			if(request.getServletPath().contains("browse")) {
				Collection<Bookmark> books = BookmarkManager.getInstance().getBookmarks(Book.class, false, userId);
				Collection<Bookmark> movies = BookmarkManager.getInstance().getBookmarks(Movie.class, false, userId);
				Collection<Bookmark> weblinks = BookmarkManager.getInstance().getBookmarks(Weblink.class, false, userId);
				request.setAttribute("books", books);
				request.setAttribute("movies", movies);
				request.setAttribute("weblinks", weblinks);
				dispatcher = request.getRequestDispatcher("/Browse.jsp");
			}	
			
			else if (request.getServletPath().contains("save")) {
				Bookmark bookmark = BookmarkManager.getInstance()
						.getBookById(Long.parseLong(request.getParameter("bid")));
				BookmarkManager.getInstance().saveUserBookmark(user, bookmark);
			} else if (request.getServletPath().contains("delete")) {
				Bookmark bookmark = BookmarkManager.getInstance()
						.getBookById(Long.parseLong(request.getParameter("bid")));
				BookmarkManager.getInstance().deleteUserBookmark(user, bookmark);
			}

		}

		else {
			request.getRequestDispatcher("/Login.jsp");
		}
		
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}