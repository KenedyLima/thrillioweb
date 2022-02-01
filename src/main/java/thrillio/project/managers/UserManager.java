package thrillio.project.managers;

import java.util.List;

import thrillio.project.constants.Gender;
import thrillio.project.constants.UserType;
import thrillio.project.dao.UserDao;
import thrillio.project.entities.User;
import thrillio.project.util.StringUtil;

public class UserManager {
	
	private static UserManager instance = new UserManager();
	private UserDao dao = UserDao.getInstance();

	private UserManager() {
	}

	public User getUserById(long userId) {
		return dao.getUserById(userId);
	}
	

	public static UserManager getInstance() {
		return instance;
	}

	public User createUser(long id, String firstName, String lastName, String email, String password, Gender gender,
			UserType userType) {

		User user = new User();
		user.setId(id);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setEmail(email);
		user.setPassword(password);
		user.setGender(gender);
		user.setUserType(userType);
		return user;
	}

	public long authenticate(String email, String password) {
		return UserDao.authenticate(email, StringUtil.encodePassword(password));
	}
}
