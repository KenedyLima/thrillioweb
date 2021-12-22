package thrillio.project;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import thrillio.project.bgjobs.WeblinkDownloader;
import thrillio.project.entities.Bookmark;
import thrillio.project.entities.User;
import thrillio.project.managers.BookmarkManager;
import thrillio.project.managers.UserManager;

public class Launch {

	private static List<User> users;
	private static List<List<Bookmark>> bookmarks;

	private static void loadData() {
		System.out.println("1. Loading Data...");
		try {
			DataStore.loadData();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		users = UserManager.getInstance().getUsers();
		bookmarks = BookmarkManager.getInstance().getBookmarks();

		//System.out.println("2. Printing Data...");
		//printUsersData();
		// printBookmarksData();
	}

	private static void printUsersData() {

		for (User user : users) {
			System.out.println(user);
		}

	}

	private static void printBookmarksData() {

		Iterator<List<Bookmark>> iterator = bookmarks.iterator();

		while (iterator.hasNext()) {
			List<Bookmark> bookmarks =  iterator.next();

			System.out.println(bookmarks);

		}

		/*
		 * for (Bookmark[] bookmarklist : bookmarks) { for (Bookmark bookmark :
		 * bookmarklist) { System.out.println(bookmark); } }
		 */

	}

	/*private static void startBookmarking() {
		System.out.println("\nBookmarking...");
		for (User user : users) {
			System.out.println("\n");
			View.browse(user, bookmarks);

		}

	}*/
	
	private static void runBgJob() {
		WeblinkDownloader task = new WeblinkDownloader(false);
		(new Thread(task)).start();

	}

	public static void main(String[] args) {
		loadData();
		//startBookmarking();
		//runBgJob();
		//sharing();
		//printBookmarksData();

	}

//	private static void sharing() {
//		for (User user : users) {
//			View.share(user, bookmarks);
//		}
//	}

}
