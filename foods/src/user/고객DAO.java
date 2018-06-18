package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class 고객DAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public 고객DAO() {
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
	
	public int login(String 고객아이디, String 고객비밀번호) {
		String SQL = "SELECT 고객비밀번호 FROM 고객 WHERE 고객아이디 = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  고객아이디);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(고객비밀번호)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			} 
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(고객 user) {
		String SQL = "INSERT INTO 고객(고객아이디, 고객비밀번호, 고객이름, 전화번호, 주소) VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.get고객아이디());
			pstmt.setString(2,  user.get고객비밀번호());
			pstmt.setString(3, user.get고객이름());
			pstmt.setString(4,  user.get전화번호());
			pstmt.setString(5,  user.get주소());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
