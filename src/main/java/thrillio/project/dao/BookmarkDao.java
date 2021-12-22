package thrillio.project.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import thrillio.project.DataStore;
import thrillio.project.constants.BookGenre;
import thrillio.project.entities.Book;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.Movie;
import thrillio.project.entities.UserBookmark;
import thrillio.project.entities.Weblink;
import thrillio.project.entities.Weblink.DownloadStatus;
import thrillio.project.managers.BookmarkManager;

public class BookmarkDao {

	public List<List<Bookmark>> getBookmarks() {
		return DataStore.getBookmarks();
	}

	public List<Weblink> getWebLinks() {
		List<Weblink> allWeblinks = new ArrayList<>();

		List<List<Bookmark>> bookmarks = DataStore.getBookmarks();
		List<Bookmark> weblinks = bookmarks.get(0);

		for (Bookmark bookmark : weblinks) {
			allWeblinks.add((Weblink) bookmark);
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

	public void saveUserBookmark(UserBookmark userBookmark) {
		// DataStore.add(userBookmark);,

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
			System.out.println("Query to updateKidFriendlyStatus" + query);
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
			System.out.println("[DATABASE UPDATE - sharedByInfo] " + bookmark.getTitle() + " was shared by "
					+ bookmark.getSharedBy().getFirstName() + bookmark.getSharedBy().getLastName());

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

public Collection<Bookmark> getBooks(boolean isBookmarked, long userId) {
		
		Collection<Bookmark> result = new ArrayList<>();
		
		System.out.println("BookmarkDao -- isBookmarked: " + isBookmarked);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//new com.mysql.jdbc.Driver(); 
			            // OR
			//System.setProperty("jdbc.drivers", "com.mysql.jdbc.Driver");
		
		                // OR java.sql.DriverManager
		    //DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root", "rootpassword");
				Statement stmt = conn.createStatement();) {			
			
			String query = "";
			if (!isBookmarked) {
				query = "Select b.id, title, image_url, publication_year, GROUP_CONCAT(a.name SEPARATOR ',') AS authors, book_genre_id, " +
									"amazon_rating from Book b, Author a, Book_Author ba where b.id = ba.book_id and ba.author_id = a.id and " + 
									"b.id NOT IN (select ub.book_id from User u, User_Book ub where u.id = " + userId +
									" and u.id = ub.user_id) group by b.id";				
			} else {
				query = "Select b.id, title, image_url, publication_year, GROUP_CONCAT(a.name SEPARATOR ',') AS authors, book_genre_id, " +
						"amazon_rating from Book b, Author a, Book_Author ba where b.id = ba.book_id and ba.author_id = a.id and " + 
						"b.id IN (select ub.book_id from User u, User_Book ub where u.id = " + userId +
						" and u.id = ub.user_id) group by b.id";
			}
			
			System.out.println("Query : " + query);
			
			
			ResultSet rs = stmt.executeQuery(query);				
			
	    	while (rs.next()) {
	    		long id = rs.getLong("id");
				String title = rs.getString("title");
				String imageUrl = rs.getString("image_url");
				int publicationYear = rs.getInt("publication_year");
				//String publisher = rs.getString("name");		
				String[] authors = rs.getString("authors").split(",");			
				int genre_id = rs.getInt("book_genre_id");
				BookGenre genre = BookGenre.values()[genre_id];
				double amazonRating = rs.getDouble("amazon_rating");
				
				System.out.println("id: " + id + ", title: " + title + ", publication year: " + publicationYear + ", authors: " + String.join(", ", authors) + ", genre: " + genre + ", amazonRating: " + amazonRating);
	    		
	    		Bookmark bookmark = BookmarkManager.getInstance().createBook(id, title, imageUrl, publicationYear, null, authors, genre, amazonRating/*, values[7]*/);
	    		result.add(bookmark); 
	    	}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

}