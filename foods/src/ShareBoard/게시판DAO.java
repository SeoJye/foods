package ShareBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class 게시판DAO {
	private Connection conn;
	private ResultSet rs;
	
	public 게시판DAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public String getNext() {
		String SQL = "SELECT 게시글번호 FROM 게시판 ORDER BY 게시글번호 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int rnum = Integer.parseInt(rs.getString(1).substring(1,4));
				String result = "S0000";
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
			return "S0001"; // 첫 번째 게시글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "S0000"; // 데이터베이스 오류
	}
	
	public int write(String 제목, String 작성자, String 내용, String 메뉴판번호) {
		String SQL = "INSERT INTO 게시판(게시글번호, 제목, 고객아이디, 작성일, 내용, 메뉴판번호) VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  getNext());
			pstmt.setString(2,  제목);
			pstmt.setString(3,  작성자);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  내용);
			pstmt.setString(6,  메뉴판번호);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<게시판> getList() {
		String SQL = "SELECT * FROM 게시판 ORDER BY 게시글번호 DESC";
		ArrayList<게시판> list = new ArrayList<게시판>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				게시판 bbs = new 게시판();
				bbs.set게시글번호(rs.getString(1));
				bbs.set제목(rs.getString(2));
				bbs.set내용(rs.getString(3));
				bbs.set작성일(rs.getString(4));
				bbs.set메뉴판번호(rs.getString(5));
				bbs.set고객아이디(rs.getString(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public 게시판 get게시판(String bbsID) {
		String SQL = "SELECT * FROM 게시판 WHERE 게시글번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				게시판 bbs = new 게시판();
				bbs.set게시글번호(rs.getString(1));
				bbs.set제목(rs.getString(2));
				bbs.set내용(rs.getString(3));
				bbs.set작성일(rs.getString(4));
				bbs.set메뉴판번호(rs.getString(5));
				bbs.set고객아이디(rs.getString(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE 게시판 SET 제목 = ?, 내용 = ? WHERE 게시글번호 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  bbsContent);
			pstmt.setString(3,  bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(String bbsID) {
		String SQL = "DELETE FROM 게시판 WHERE 게시글번호 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
