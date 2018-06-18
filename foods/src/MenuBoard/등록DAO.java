package MenuBoard;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class 등록DAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public 등록DAO() {
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
	
	public int resistMenu(String 메뉴판번호, String 메뉴번호) {
		String SQL = "INSERT INTO 등록(메뉴판번호, 메뉴번호) VALUES(?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  메뉴판번호);
			pstmt.setString(2,  메뉴번호);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public 등록 get등록(String 메뉴판번호) {
		String SQL = "SELECT * FROM 등록 WHERE 메뉴판번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴판번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				등록 res = new 등록();
				res.set메뉴판번호(rs.getString(1));
				res.set메뉴번호(rs.getString(2));
				return res;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<등록> getList(String 메뉴판번호) {
		String SQL = "SELECT * FROM 등록 WHERE 메뉴판번호 = ? ORDER BY 메뉴번호 ASC";
		ArrayList<등록> list = new ArrayList<등록>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴판번호);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				등록 dbs = new 등록();
				dbs.set메뉴판번호(rs.getString(1));
				dbs.set메뉴번호(rs.getString(2));
				list.add(dbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<String> get메뉴번호List(String 메뉴판번호) {
		String SQL = "SELECT 메뉴번호 FROM 등록 WHERE 메뉴판번호 = ? ORDER BY 메뉴번호 ASC";
		ArrayList<String> list = new ArrayList<String>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 메뉴판번호);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				등록 dbs = new 등록();
				dbs.set메뉴번호(rs.getString(1));
				list.add(dbs.get메뉴번호());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
