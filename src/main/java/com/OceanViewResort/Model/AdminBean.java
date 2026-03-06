package com.OceanViewResort.Model;

public class AdminBean {
	
	    private int adminId;
	    private String username;
	    private String password;

	    public AdminBean() {}

	    public AdminBean(String username, String password) {
	        this.username = username;
	        this.password = password;
	    }

	    public String getUsername() { return username; }
	    public String getPassword() { return password; }

	    public void setUsername(String username) { this.username = username; }
	    public void setPassword(String password) { this.password = password; }

		public int getAdminId() {
			return adminId;
		}

		public void setAdminId(int adminId) {
			this.adminId = adminId;
		}

}