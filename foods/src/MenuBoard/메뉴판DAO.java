package MenuBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class 메뉴판DAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public 메뉴판DAO() {
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
	
	public String getNext() {
		String SQL = "SELECT 메뉴판번호 FROM 메뉴판 ORDER BY 메뉴판번호 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int rnum = Integer.parseInt(rs.getString(1).substring(1,4));
				String result = "Z0000";
				if((rnum + 1) < 10) 
					result = rs.getString(1).substring(0,1) + "000" + (Integer.parseInt(rs.getString(1).substring(1,5)) + 1);
				else if((rnum + 1) < 100)
					result = rs.getString(1).substring(0,1) + "00" + (Integer.parseInt(rs.getString(1).substring(1,5)) + 1);
				else if((rnum + 1) < 1000)
					result = rs.getString(1).substring(0,1) + "0" + (Integer.parseInt(rs.getString(1).substring(1,5)) + 1);
				else if((rnum + 1) < 10000)
					result = rs.getString(1).substring(0,1) + (Integer.parseInt(rs.getString(1).substring(1,5)) + 1);
				
				return result;
			}
			return "Z0001"; // 첫 번째 메뉴판인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Z0000"; // 데이터베이스 오류
	}
	
	public int addBoard(String 메뉴판이름, String 고객아이디) {
		String SQL = "INSERT INTO 메뉴판(메뉴판번호, 메뉴판이름, 고객아이디) VALUES(?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  getNext());
			pstmt.setString(2,  메뉴판이름);
			pstmt.setString(3,  고객아이디);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<메뉴판> getList() {
		String SQL = "SELECT * FROM 메뉴판 ORDER BY 메뉴판번호 DESC";
		ArrayList<메뉴판> list = new ArrayList<메뉴판>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				메뉴판 mbs = new 메뉴판();
				mbs.set메뉴판번호(rs.getString(1));
				mbs.set메뉴판이름(rs.getString(2));
				mbs.set고객아이디(rs.getString(3));
				list.add(mbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public 메뉴판 get메뉴판(String 메뉴판번호) {
		String SQL = "SELECT * FROM 메뉴판 WHERE 메뉴판번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴판번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				메뉴판 mbs = new 메뉴판();
				mbs.set메뉴판번호(rs.getString(1));
				mbs.set메뉴판이름(rs.getString(2));
				mbs.set고객아이디(rs.getString(3));
				return mbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int deleteBoard(String 메뉴판번호) {
		String SQL = "DELETE FROM 메뉴판 WHERE 메뉴판번호 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  메뉴판번호);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
