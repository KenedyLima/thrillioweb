package thrillio.project.managers;

import java.util.Collection;
import java.util.List;

import thrillio.project.constants.BookGenre;
import thrillio.project.constants.KidFriendlyStatus;
import thrillio.project.constants.MovieGenre;
import thrillio.project.dao.BookmarkDao;
import thrillio.project.entities.Book;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.Movie;
import thrillio.project.entities.User;
import thrillio.project.entities.UserBookmark;
import thrillio.project.entities.Weblink;

public class BookmarkManager {

	private BookmarkManager() {
	}

	private static BookmarkDao dao = new BookmarkDao();
	public static BookmarkManager instance = new BookmarkManager();

	public static BookmarkManager getInstance() {
		return instance;
	}
	
	public List<List<Bookmark>> getBookmarks() {
		return dao.getBookmarks();
	}
	
	public Movie createMovie(long id, String title, String profileUrl, int releaseYear, String cast[],
			String[] directors, MovieGenre genre, double imdbRating) {

		Movie movie = new Movie();
		movie.setId(id);
		movie.setTitle(title);
		movie.setProfileUrl(profileUrl);
		movie.setReleaseYear(releaseYear);
		movie.setCast(cast);
		movie.setDirectors(directors);
		movie.setGenre(genre);
		movie.setImdbRating(imdbRating);
		return movie;
	}

	public Weblink createWebLink(Long id, String title, String url, String host) {
		Weblink weblink = new Weblink();
		weblink.setId(id);
		weblink.setTitle(title);
		weblink.setUrl(url);
		weblink.setHost(host);
		return weblink;
	}

	public static void saveUserBookmark(User user,
			Bookmark bookmark) /* throws MalformedURLException, URISyntaxException */ {
		UserBookmark userBookmark = new UserBookmark();
		userBookmark.setUser(user);
		userBookmark.setBookmark(bookmark);

		dao.saveUserBookmark(userBookmark);

	}

	public void setKidFriendlyStatus(User user, KidFriendlyStatus kidFriendlyStatusDecision, Bookmark bookmark) {

		// System.out.println("setKidFriendlyStatus - BookmarkManager");

		bookmark.setKidFriendlyStatus(kidFriendlyStatusDecision);
		bookmark.setKidFriendlyMarkedBy(user);

		System.out.println("[KIDFRIENDLYSTATUS]=" + kidFriendlyStatusDecision + ", bookmarked by=" + user.getEmail()
				+ "[" + bookmark + "]=");

		dao.updateKidFriendlyStatus(bookmark);

	}

	public void share(User user, Bookmark bookmark) {
		bookmark.setSharedBy(user);
		System.out.println("[SHARING] -- " + user.getEmail() + bookmark.getTitle());
		if (bookmark instanceof Book) {
			System.out.println("[ITEM_DATA] " + ((Book) bookmark).getItemData());
		} else if (bookmark instanceof Weblink) {
			System.out.println("[ITEM_DATA] " + ((Weblink) bookmark).getItemData());

		}
		
		dao.sharedByInfo(bookmark);
	}

	public Book createBook(long id, String title, String imageUrl, int publicationYear, String publisher, String[] authors,
			BookGenre genre, double amazonRating) {
		Book book = new Book();

		book.setId(id);
		book.setTitle(title);
		book.setImageUrl(imageUrl);
		book.setPublicationYear(publicationYear);
		book.setPublisher(publisher);
		book.setAuthors(authors);
		book.setGenre(genre);
		book.setAmazonRating(amazonRating);

		return book;
	}	
	
	public Collection<Bookmark> getBooks(boolean isBookmarked, long userId){
		Collection<Bookmark> result = dao.getBooks(isBookmarked, userId);
		System.out.println("RESULT FROM BOOKMARKMANAGER" + result);
		return result;
	}
	
}
