package thrillio.project;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import thrillio.project.constants.BookGenre;
import thrillio.project.constants.Gender;
import thrillio.project.constants.KidFriendlyStatus;
import thrillio.project.constants.MovieGenre;
import thrillio.project.constants.UserType;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.User;
import thrillio.project.entities.UserBookmark;
import thrillio.project.managers.BookmarkManager;
import thrillio.project.managers.UserManager;

public class DataStore {

	private static List<User> users = new ArrayList<>();

	public static List<User> getUsers() {
		return users;
	}

	private static List<List<Bookmark>> bookmarks = new ArrayList<>();

	public static List<List<Bookmark>> getBookmarks() {
		return bookmarks;
	}

	private static List<UserBookmark> userBookmarks = new ArrayList<>();

	// private static int bookmarkIndex;

	public static void loadData() throws SQLException {
		// loadUsers();
		// loadWebLinks();
		// loadMovies();
		// loadBooks();

		System.out.println("Loading JDBC Driver... ");
		try {
			new com.mysql.cj.jdbc.Driver();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root", "rootpassword");
				Statement stmt = conn.createStatement()) {

			loadUsers(stmt);
			loadWebLinks(stmt);
			loadBooks(stmt);
			loadMovies(stmt);

		}

	}

	private static void loadUsers(Statement stmt) throws SQLException {

		String query = "select * from user";

		ResultSet rs = stmt.executeQuery(query);

		while (rs.next()) {

			long id = rs.getLong(1);
			String email = rs.getString(2);
			String password = rs.getString(3);
			String firstName = rs.getString(4);
			String lastName = rs.getString(5);
			Gender gender = Gender.values()[rs.getInt(6)];
			UserType userType = UserType.values()[rs.getInt(7)];
			
			//System.out.println("[USER] id " + id + " first name " + firstName + " email " + email);
			User user = UserManager.getInstance().createUser(id, firstName, lastName, email, password, gender,
					userType);
			users.add(user);

		}

	}

	private static void loadWebLinks(Statement stmt) throws SQLException {
		
		String query = "select * from weblink";
		
		ResultSet rs = stmt.executeQuery(query);

		List<Bookmark> bookmarkList = new ArrayList<>();

		while (rs.next()) {
			long id = rs.getLong(1);
			String title = rs.getString(2);
			String url = rs.getString(3);
			String host = rs.getString(4);
			KidFriendlyStatus kfStatus = KidFriendlyStatus.values()[rs.getInt(5)];
			//Date date = rs.getDate(6); 
			
			StringBuilder weblink = new StringBuilder();
			
			weblink.append("[NEW WEBLINK] id " + id + " ").append("title " + title + " ").append("url " + url + " ").append("host" + host);
		//	System.out.println(weblink.toString());

			Bookmark bookmark = BookmarkManager.getInstance().createWebLink(id, title,
					url, host);

			bookmarkList.add(bookmark);
		}

		bookmarks.add(bookmarkList);
	}

	private static void loadMovies(Statement stmt) throws SQLException {
		String query = "Select m.id, title, release_year, GROUP_CONCAT(DISTINCT a.name SEPARATOR ',') AS cast, GROUP_CONCAT(DISTINCT d.name SEPARATOR ',') AS directors, movie_genre_id, imdb_rating"
				+ " from Movie m, Actor a, Movie_Actor ma, Director d, Movie_Director md "
				+ "where m.id = ma.movie_id and ma.actor_id = a.id and "
				+ "m.id = md.movie_id and md.director_id = d.id group by m.id";
		ResultSet rs = stmt.executeQuery(query);

		List<Bookmark> bookmarkList = new ArrayList<>();
		while (rs.next()) {
			long id = rs.getLong("id");
			String title = rs.getString("title");
			int releaseYear = rs.getInt("release_year");
			String[] cast = rs.getString("cast").split(",");
			String[] directors = rs.getString("directors").split(",");
			int genre_id = rs.getInt("movie_genre_id");
			MovieGenre genre = MovieGenre.values()[genre_id];
			double imdbRating = rs.getDouble("imdb_rating");

		//	System.out.println("[NEW MOVIE] id " + id + "title " + title + "release year " + releaseYear + "cast " + cast.toString());
			Bookmark bookmark = BookmarkManager.getInstance().createMovie(id, title, "", "", releaseYear, cast, directors,
					genre, imdbRating/* , values[7] */);
			bookmarkList.add(bookmark);
		}
		bookmarks.add(bookmarkList);

	}

	private static void loadBooks(Statement stmt) throws SQLException {		    	
		String query = "Select b.id, title, publication_year, p.name, GROUP_CONCAT(a.name SEPARATOR ',') AS authors, book_genre_id, amazon_rating, created_date"
				+ " from Book b, Publisher p, Author a, Book_Author ba "
				+ "where b.publisher_id = p.id and b.id = ba.book_id and ba.author_id = a.id group by b.id";
    	ResultSet rs = stmt.executeQuery(query);
		
    	List<Bookmark> bookmarkList = new ArrayList<>();
    	while (rs.next()) {
    		long id = rs.getLong("id");
			String title = rs.getString("title");
			String imageUrl = rs.getString(3);
			int publicationYear = rs.getInt("publication_year");
			String publisher = rs.getString("name");		
			String[] authors = rs.getString("authors").split(",");			
			int genre_id = rs.getInt("book_genre_id");
			BookGenre genre = BookGenre.values()[genre_id];
			double amazonRating = rs.getDouble("amazon_rating");
			
			Date createdDate = rs.getDate("created_date");
			//System.out.println("createdDate: " + createdDate);
			Timestamp timeStamp = rs.getTimestamp(8);
			//System.out.println("timeStamp: " + timeStamp);
			//System.out.println("localDateTime: " + timeStamp.toLocalDateTime());
			
		//	System.out.println("[NEW BOOK] id: " + id + ", title: " + title + ", publication year: " + publicationYear + ", publisher: " + publisher + ", authors: " + String.join(", ", authors) + ", genre: " + genre + ", amazonRating: " + amazonRating);
    		
    		Bookmark bookmark = BookmarkManager.getInstance().createBook(id, title, imageUrl, publicationYear, publisher, authors, genre, amazonRating/*, values[7]*/);
    		bookmarkList.add(bookmark); 
    	}
    	bookmarks.add(bookmarkList);
    }	

	public static void add(UserBookmark userBookmark) {
		userBookmarks.add(userBookmark);

	}

}
