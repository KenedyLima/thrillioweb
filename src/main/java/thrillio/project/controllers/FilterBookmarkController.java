package thrillio.project.controllers;

import java.io.IOException;
import java.util.Collection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import thrillio.project.entities.Book;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.Movie;
import thrillio.project.entities.Weblink;
import thrillio.project.managers.BookmarkManager;

@WebServlet(urlPatterns = { "/bookmarks", "/bookmarks/movies", "/bookmarks/books", "/bookmarks/weblinks" })
public class FilterBookmarkController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FilterBookmarkController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = null;
		Collection<Bookmark> books = null;
		Collection<Bookmark> movies = null;
		Collection<Bookmark> weblinks = null;

		if (request.getSession().getAttribute("userId") != null) {
			long userId = (long) request.getSession().getAttribute("userId");

			if (request.getServletPath().contains("books")) {
				books = BookmarkManager.getInstance().getBookmarks(Book.class, true, userId);
			} else if (request.getServletPath().contains("movies")) {
				movies = BookmarkManager.getInstance().getBookmarks(Movie.class, true, userId);

			} else if (request.getServletPath().contains("weblinks")) {
				weblinks = BookmarkManager.getInstance().getBookmarks(Weblink.class, true, userId);

			} else {
				books = BookmarkManager.getInstance().getBookmarks(Book.class, true, userId);
				movies = BookmarkManager.getInstance().getBookmarks(Movie.class, true, userId);
				weblinks = BookmarkManager.getInstance().getBookmarks(Weblink.class, true, userId);
			}
			request.setAttribute("books", books);
			request.setAttribute("movies", movies);
			request.setAttribute("weblinks", weblinks);

			dispatcher = request.getRequestDispatcher("/MyBooks.jsp");
		

		} else {
			dispatcher = request.getRequestDispatcher("/auth");
		}

		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
