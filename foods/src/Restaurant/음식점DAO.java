package Restaurant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class 음식점DAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public 음식점DAO() {
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
	public 음식점 get분류(String 분류) {
		String SQL = "SELECT * FROM 음식점 WHERE 분류  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 분류);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				음식점 res = new 음식점();
				res.set음식점번호(rs.getString(1));
				res.set음식점이름(rs.getString(2));
				res.set전화번호(rs.getString(3));
				res.set음식점주소(rs.getString(4));
				res.set영업시간(rs.getString(5));
				res.set소개(rs.getString(6));
				res.set분류(rs.getString(7));
				res.set주문수(rs.getInt(8));
				res.set평점(rs.getInt(9));
				return res;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public 음식점 get음식점(String 음식점번호) {
		String SQL = "SELECT * FROM 음식점 WHERE 음식점번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 음식점번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				음식점 res = new 음식점();
				res.set음식점번호(rs.getString(1));
				res.set음식점이름(rs.getString(2));
				res.set전화번호(rs.getString(3));
				res.set음식점주소(rs.getString(4));
				res.set영업시간(rs.getString(5));
				res.set소개(rs.getString(6));
				res.set분류(rs.getString(7));
				res.set주문수(rs.getInt(8));
				res.set평점(rs.getInt(9));
				return res;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String get음식점이름(String 음식점번호) {
		String SQL = "SELECT 음식점이름 FROM 음식점 WHERE 음식점번호  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, 음식점번호);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public 음식점 get분류이름(String 분류) {
		String SQL="select 분류 from 음식점  where 분류=? ";
        
		try {
	           PreparedStatement pstmt=conn.prepareStatement(SQL);
	           pstmt.setString(1, 분류);
	           rs=pstmt.executeQuery();
	           if(rs.next()) {
	        	    음식점 food=new 음식점();
	              food.set분류(rs.getString(1));
	              food.set음식점이름(rs.getString(1));
	              food.set평점(rs.getInt(2));
	              food.set주문수(rs.getInt(3));
	              return food;
		           }
		        } catch(Exception e) {
		           e.printStackTrace();
		        }
		        return null;
	}
	

	public ArrayList<음식점> rank() {
        String SQL="select 음식점이름, 평점, 주문수 from 음식점 order by 평점 desc, 주문수 desc, 음식점이름 asc limit 10";
        ArrayList<음식점> list=new ArrayList<음식점>();
        try {
           PreparedStatement pstmt=conn.prepareStatement(SQL);
           rs=pstmt.executeQuery();
           while(rs.next()) {
        	    음식점 food=new 음식점();
              food.set음식점이름(rs.getString(1));
              food.set평점(rs.getInt(2));
              food.set주문수(rs.getInt(3));
              list.add(food);
           }
        } catch(Exception e) {
           e.printStackTrace();
        }
        return list;
     }
	public ArrayList<음식점> mlist(String 분류) {
        String SQL="select 음식점이름,평점,주문수,음식점번호 from 음식점  where 분류=? ORDER BY  평점 desc, 주문수 desc, 음식점이름 asc,음식점번호 asc";
        ArrayList<음식점> list=new ArrayList<음식점>();
        try {
           PreparedStatement pstmt=conn.prepareStatement(SQL);
           pstmt.setString(1, 분류);
           rs=pstmt.executeQuery();
           while(rs.next()) {
        	    음식점 food=new 음식점();
                food.set음식점이름(rs.getString(1));
                food.set평점(rs.getInt(2));
                food.set주문수(rs.getInt(3));
                food.set음식점번호(rs.getString(4));
              list.add(food);
           }
        } catch(Exception e) {
           e.printStackTrace();
        }
        return list;
     }
	
}
