package thrillio.project.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import thrillio.project.constants.BookGenre;
import thrillio.project.constants.MovieGenre;
import thrillio.project.entities.Book;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.Movie;
import thrillio.project.entities.UserBookmark;
import thrillio.project.entities.Weblink;
import thrillio.project.entities.Weblink.DownloadStatus;
import thrillio.project.managers.BookmarkManager;

public class BookmarkDao {

	private static BookmarkDao instance = new BookmarkDao();

	private BookmarkDao() {
		loadJDBCDriver();
	}

	public static BookmarkDao getInstance() {
		return instance;
	}

	private static void loadJDBCDriver() {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}

	public Bookmark getBookById(long bookId) {

		Bookmark book = new Book();

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {
			String query = "SELECT * from book where id = " + bookId;
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {

				String title = rs.getString(2);
				int publicationYear = rs.getInt(4);
				BookGenre genre = BookGenre.values()[rs.getInt(6)];
				double amazonRating = rs.getDouble(7);
				book = BookmarkManager.getInstance().createBook(bookId, title, null, publicationYear, null, null, genre,
						amazonRating);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return book;
	}

	public void saveUserBookmark(UserBookmark userBookmark) {

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {

			if (userBookmark.getBookmark() instanceof Book) {
				saveUser_Book(userBookmark, stmt);
			}

			else if (userBookmark.getBookmark() instanceof Movie) {
				saveUser_Movie(userBookmark, stmt);
			}

			else {
				saveUser_Weblink(userBookmark, stmt);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private void saveUser_Weblink(UserBookmark userBookmark, Statement stmt) throws SQLException {
		String query = "insert into user_weblink(user_id, weblink_id) values (" + userBookmark.getUser().getId() + ", "
				+ userBookmark.getBookmark().getId() + ");";
		stmt.executeUpdate(query);
	}

	private void saveUser_Movie(UserBookmark userBookmark, Statement stmt) throws SQLException {
		String query = "insert into user_movie(user_id, movie_id) values (" + userBookmark.getUser().getId() + ", "
				+ userBookmark.getBookmark().getId() + ");";
		stmt.executeUpdate(query);

	}

	private void saveUser_Book(UserBookmark userBookmark, Statement stmt) throws SQLException {
		String query = "insert into user_book(user_id, book_id) values (" + userBookmark.getUser().getId() + ", "
				+ userBookmark.getBookmark().getId() + ");";
		stmt.executeUpdate(query);

	}

	public void deleteUserBookmark(UserBookmark userBookmark) {
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {
			if (userBookmark.getBookmark() instanceof Book) {
				deleteUser_Book(userBookmark, stmt);
			} else if (userBookmark.getBookmark() instanceof Movie) {
				deleteUser_Movie(userBookmark, stmt);
			} else {
				deleteUser_Weblink(userBookmark, stmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void deleteUser_Weblink(UserBookmark userBookmark, Statement stmt) throws SQLException {
		String query = "DELETE FROM user_weblink where user_id = " + userBookmark.getUser().getId() + " AND weblink_id = "
				+ userBookmark.getBookmark().getId();
		stmt.executeUpdate(query);
	}

	private void deleteUser_Movie(UserBookmark userBookmark, Statement stmt) throws SQLException {
		String query = "DELETE FROM user_movie where user_id = " + userBookmark.getUser().getId() + " AND movie_id = "
				+ userBookmark.getBookmark().getId();
		stmt.executeUpdate(query);

	}

	private void deleteUser_Book(UserBookmark userBookmark, Statement stmt) throws SQLException {
		String query = "DELETE FROM user_book where user_id = " + userBookmark.getUser().getId() + " AND book_id = "
				+ userBookmark.getBookmark().getId();
		stmt.executeUpdate(query);

	}

	public Collection<Bookmark> getAllBookmarks(boolean isBookmarked, long userId) {
		Collection<Bookmark> result = new ArrayList<>();

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement();) {
			result.addAll(getBooks(isBookmarked, userId, stmt));
			result.addAll(getMovies(isBookmarked, userId, stmt));
			result.addAll(getWeblinks(isBookmarked, userId, stmt));

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	public Collection<Bookmark> getBookmarks(Class<? extends Bookmark> classType, boolean isBookmarked, long userId) {
		Collection<Bookmark> result = new ArrayList<>();

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement();) {

			if (classType.getCanonicalName().equals(Book.class.getCanonicalName())) {
				result.addAll(getBooks(isBookmarked, userId, stmt));
			} else if (classType.getCanonicalName().equals(Movie.class.getCanonicalName())) {
				result.addAll(getMovies(isBookmarked, userId, stmt));
			} else if (classType.getCanonicalName().equals(Weblink.class.getCanonicalName())) {
				result.addAll(getWeblinks(isBookmarked, userId, stmt));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	private Collection<Bookmark> getWeblinks(boolean isBookmarked, long userId, Statement stmt) throws SQLException {
		Collection<Bookmark> weblinks = new ArrayList<>();

		String query = "";

		if (isBookmarked) {
			query = "SELECT * from weblink wb where wb.id IN (SELECT weblink_id from user_weblink where user_id = "
					+ userId + ")";
		} else {
			query = "SELECT * from weblink wb where wb.id NOT IN (SELECT weblink_id from user_weblink where user_id = "
					+ userId + ")";
		}

		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			weblinks.add(BookmarkManager.getInstance().createWebLink(rs.getLong(1), rs.getString(2), rs.getString(3),
					rs.getString(4)));
		}
		return weblinks;
	}

	private Collection<Bookmark> getMovies(boolean isBookmarked, long userId, Statement stmt) throws SQLException {
		Collection<Bookmark> movies = new ArrayList<>();
		String query = "";

		if (isBookmarked) {
			query = "SELECT * from movie mv where mv.id IN (SELECT movie_id from user_movie where user_id = " + userId
					+ ")";
		} else {
			query = "SELECT * from movie mv where mv.id NOT IN (SELECT movie_id from user_movie where user_id = "
					+ userId + ")";
		}
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			movies.add(BookmarkManager.getInstance().createMovie(rs.getLong(1), rs.getString(2), rs.getString(3), null,
					rs.getInt(4), null, null, MovieGenre.values()[rs.getInt(5)], rs.getDouble(6)));
			System.out.println("movieUrl: " + rs.getString(3));
		}
		return movies;

	}

	private Collection<Bookmark> getBooks(boolean isBookmarked, long userId, Statement stmt) throws SQLException {

		Collection<Bookmark> books = new ArrayList<>();

		String query = "";
		if (!isBookmarked) {
			query = "Select b.id, title, image_url, publication_year, GROUP_CONCAT(a.name SEPARATOR ',') AS authors, book_genre_id, "
					+ "amazon_rating from book b, author a, book_author ba where b.id = ba.book_id and ba.author_id = a.id and "
					+ "b.id NOT IN (select ub.book_id from user u, user_book ub where u.id = " + userId
					+ " and u.id = ub.user_id) group by b.id";
		} else {
			query = "Select b.id, title, image_url, publication_year, GROUP_CONCAT(a.name SEPARATOR ',') AS authors, book_genre_id, "
					+ "amazon_rating from book b, author a, book_author ba where b.id = ba.book_id and ba.author_id = a.id and "
					+ "b.id IN (select ub.book_id from user u, user_book ub where u.id = " + userId
					+ " and u.id = ub.user_id) group by b.id";
		}

		ResultSet rs = stmt.executeQuery(query);

		while (rs.next()) {
			long id = rs.getLong("id");
			String title = rs.getString("title");
			String imageUrl = rs.getString("image_url");
			int publicationYear = rs.getInt("publication_year");
			// String publisher = rs.getString("name");
			String[] authors = rs.getString("authors").split(",");
			int genre_id = rs.getInt("book_genre_id");
			BookGenre genre = BookGenre.values()[genre_id];
			double amazonRating = rs.getDouble("amazon_rating");

			Bookmark bookmark = BookmarkManager.getInstance().createBook(id, title, imageUrl, publicationYear, null,
					authors, genre, amazonRating/* , values[7] */);
			books.add(bookmark);
		}

		return books;
	}

	public void updateKidFriendlyStatus(Bookmark bookmark) {

		int kidFriendlyStatus = bookmark.getKidFriendlyStatus().ordinal();
		long userID = bookmark.getKidFriendlyMarkedBy().getId();

		String tableToUpdate = "Book";

		if (bookmark instanceof Movie) {
			tableToUpdate = "Movie";
		} else if (bookmark instanceof Weblink) {
			tableToUpdate = "Weblink";
		}

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {

			String query = "update " + tableToUpdate + " set kid_friendly_status = " + kidFriendlyStatus
					+ ", kid_friendly_marked_by = " + userID + " where id = " + bookmark.getId();
			stmt.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void sharedByInfo(Bookmark bookmark) {
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {

			String tableToUpdate = "book";
			long userID = bookmark.getSharedBy().getId();
			long bookmarkID = bookmark.getId();
			if (bookmark instanceof Weblink) {
				tableToUpdate = "weblink";
			}

			String query = "update " + tableToUpdate + " set shared_by = " + userID + " where id = " + bookmarkID;
			stmt.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public List<Weblink> getWebLinks() {
		List<Weblink> allWeblinks = new ArrayList<>();
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {

			String query = "SELECT * FROM weblink";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				long id = rs.getLong(1);
				String title = rs.getString(2);
				String url = rs.getString(3);
				String host = rs.getString(4);
				Weblink weblink = BookmarkManager.getInstance().createWebLink(id, title, url, host);
				allWeblinks.add(weblink);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return allWeblinks;
	}

	public List<Weblink> getWeblinks(DownloadStatus downloadStatus) {
		List<Weblink> weblinks = getWebLinks();

		List<Weblink> weblinksNotAttempted = getWebLinks();

		for (Weblink weblink : weblinks) {
			if (weblink.getDownloadStatus().equals(downloadStatus)) {
				weblinksNotAttempted.add(weblink);
			}
		}

		return weblinksNotAttempted;
	}

	public Bookmark getMovieById(long movieId) {

		Bookmark movie = new Movie();

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {
			String query = "SELECT * from movie where id = " + movieId;
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {

				movie = BookmarkManager.getInstance().createMovie(rs.getLong(1), rs.getString(2), rs.getString(3), null,
						rs.getInt(4), null, null, MovieGenre.values()[rs.getInt(5)], rs.getDouble(6));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return movie;
	}

	public Bookmark getWeblinkById(long weblinkId) {

		Bookmark weblink = new Weblink();

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {
			String query = "SELECT * from movie where id = " + weblinkId;
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {

				weblink = BookmarkManager.getInstance().createWebLink(rs.getLong(1), rs.getString(2), rs.getString(3), rs.getString(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return weblink;
	}

}