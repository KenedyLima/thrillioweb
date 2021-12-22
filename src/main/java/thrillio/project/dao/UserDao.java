package thrillio.project.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import thrillio.project.DataStore;
import thrillio.project.entities.User;

public class UserDao {

	public List<User> getUsers() {
		return DataStore.getUsers();
	}

	public static long authenticate(String email, String password) {
		try {
			new com.mysql.cj.jdbc.Driver();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		long userID = -1;

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jid_thrillio", "root",
				"rootpassword"); Statement stmt = conn.createStatement()) {

			String query = "Select id from user where email = '" + email + "' and password = '" + password + "'";
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				userID = rs.getLong("password");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
}
