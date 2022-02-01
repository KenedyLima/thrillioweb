package thrillio.project.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


import thrillio.project.constants.Gender;
import thrillio.project.constants.UserType;
import thrillio.project.entities.User;
import thrillio.project.managers.UserManager;

public class UserDao {

	private static UserDao instance = new UserDao();

	private UserDao() {
		loadJDBCDriver();
	}

	private static void loadJDBCDriver() {
		try {
			new com.mysql.cj.jdbc.Driver();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public static UserDao getInstance() {
		return instance;
	}



	public static long authenticate(String email, String password) {
		loadJDBCDriver();

		long userID = -1;

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {

			String query = "Select id from user where email = '" + email + "' and password = '" + password + "'";
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				userID = rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userID;
	}

	public User getUserById(long userId) {

		User user = new User();
		
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {
			

			String query = "select * from user where id = " + userId;
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				String email = rs.getString(2);
				String password = rs.getString(3);
				String firstName = rs.getString(4);
				String lastName = rs.getString(5);
				Gender gender = Gender.values()[rs.getInt(6)];
				UserType userType = UserType.values()[rs.getInt(7)];

				user = UserManager.getInstance().createUser(userId, firstName, lastName, email, password, gender,
						userType);
			}

		
		}

		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}
}
