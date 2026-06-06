package com.blooddonor.model;

import java.sql.Date;

public class Donation {

    private int donationId;
    private int donorId;
    private int requestId;
    private Date donationDate;
    private String status;

    
    public int getDonationId() { return donationId; }
    public void setDonationId(int donationId) { this.donationId = donationId; }

    public int getDonorId() { return donorId; }
    public void setDonorId(int donorId) { this.donorId = donorId; }

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public Date getDonationDate() { return donationDate; }
    public void setDonationDate(Date donationDate) { this.donationDate = donationDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}