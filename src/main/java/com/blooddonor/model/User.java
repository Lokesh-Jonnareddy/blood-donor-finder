package com.blooddonor.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {

    private int userId;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String city;
    private String area;
    private String bloodGroup;
    private String role;
    private String badge;
    private int donationCount;
    private Date lastDonatedDate;
    private Timestamp registeredDate;

    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getArea() { return area; }
    public void setArea(String area) { this.area = area; }

    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }

    public int getDonationCount() { return donationCount; }
    public void setDonationCount(int donationCount) { this.donationCount = donationCount; }

    public Date getLastDonatedDate() { return lastDonatedDate; }
    public void setLastDonatedDate(Date lastDonatedDate) { this.lastDonatedDate = lastDonatedDate; }

    public Timestamp getRegisteredDate() { return registeredDate; }
    public void setRegisteredDate(Timestamp registeredDate) { this.registeredDate = registeredDate; }
}