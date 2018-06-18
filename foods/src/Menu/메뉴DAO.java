package Menu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import MenuBoard.등록;
import Restaurant.음식점;

public class 메뉴DAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public 메뉴DAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/foods?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public 메뉴 get메뉴(String 메뉴번호) {
		String SQL = "SELECT * FROM 메뉴 WHERE 메뉴번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				메뉴 menu = new 메뉴();
				menu.set메뉴번호(rs.getString(1));
				menu.set메뉴이름(rs.getString(2));
				menu.set메뉴가격(rs.getInt(3));
				menu.set음식점번호(rs.getString(4));
				return menu;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public ArrayList<메뉴> nlist(String 음식점번호) {
        String SQL="select * from 메뉴  where 음식점번호=?";
        ArrayList<메뉴> list=new ArrayList<메뉴>();
        try {
           PreparedStatement pstmt=conn.prepareStatement(SQL);
           pstmt.setString(1, 음식점번호);
           rs=pstmt.executeQuery();
           while(rs.next()) {
        	    메뉴 res=new 메뉴();
				res.set메뉴번호(rs.getString(1));
				res.set메뉴이름(rs.getString(2));
				res.set메뉴가격(rs.getInt(3));
				res.set음식점번호(rs.getString(4));

              list.add(res);
           }
        } catch(Exception e) {
           e.printStackTrace();
        }
        return list;
     }
	
	public ArrayList<메뉴> getList(String 음식점번호) {
		String SQL = "SELECT * FROM 메뉴 WHERE 음식점번호 = ? ORDER BY 메뉴번호 ASC";
		ArrayList<메뉴> list = new ArrayList<메뉴>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 음식점번호);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				메뉴 menu = new 메뉴();
				menu.set메뉴번호(rs.getString(1));
				menu.set메뉴이름(rs.getString(2));
				menu.set메뉴가격(rs.getInt(3));
				menu.set음식점번호(rs.getString(4));
				list.add(menu);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String get음식점번호(String 메뉴번호) {
		String SQL = "SELECT 음식점번호 FROM 메뉴 WHERE 메뉴번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String get메뉴이름(String 메뉴번호) {
		String SQL = "SELECT 메뉴이름 FROM 메뉴 WHERE 메뉴번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int get메뉴가격(String 메뉴번호) {
		String SQL = "SELECT 메뉴가격 FROM 메뉴 WHERE 메뉴번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
