package thrillio.project.entities;

import thrillio.project.constants.Gender;
import thrillio.project.constants.UserType;

public class User {

	private String firstName;
	private String email;
	private String password;
	private UserType userType = UserType.USER;
	private String lastName;
	private Gender gender;
	private long id;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public UserType getUserType() {
		return userType;
	}

	public void setUserType(UserType userType) {
		this.userType = userType;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "User [firstName=" + firstName + ", email=" + email + ", password=" + password + ", userType=" + userType
				+ ", lastName=" + lastName + ", gender=" + gender + ", id=" + id + "]";
	}
}
