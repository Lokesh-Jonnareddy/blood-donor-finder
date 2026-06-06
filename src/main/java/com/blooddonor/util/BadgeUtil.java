package com.blooddonor.util;

public class BadgeUtil {

    public static String getBadge(int donationCount) {
        if (donationCount == 0) return "New Donor";
        else if (donationCount == 1) return "First Drop";
        else if (donationCount >= 2 && donationCount <= 4) return "Life Helper";
        else if (donationCount >= 5 && donationCount <= 9) return "Life Saver";
        else return "Hero Donor";
    }

    public static boolean canDonateAgain(java.sql.Date lastDonatedDate) {
        if (lastDonatedDate == null) return true;
        long diff = System.currentTimeMillis() - lastDonatedDate.getTime();
        long daysDiff = diff / (1000 * 60 * 60 * 24);
        return daysDiff >= 90;
    }
}