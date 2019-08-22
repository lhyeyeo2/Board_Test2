package board;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;


public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();
	
	private BoardDBBean() {}
	
	public static BoardDBBean getInstance() {
		return instance;
		
	}


	
	public Connection getConnection() throws Exception{
		Context initContext= new InitialContext ();
		Context envContext= (Context) initContext.lookup("java:comp/env");
		DataSource ds= (DataSource)envContext.lookup("jdbc/oracle");
		return ds.getConnection();
		//context,랑 lookup 하는 이유. 형변환 관련 응?
		//throw Exception 쓰는 이유-> try, Exception e로 썼었음.다음 행에 try, Exception 썼고,
	}
		@SuppressWarnings("resource")
		public void insertArticle(BoardDataBean article) throws Exception {
			//db 연결하고 sql insert into~
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			//to_do
			
			int num=article.getNum();
			int ref=article.getRef();
			int re_step=article.getReStep();
			int re_level=article.getReLevel();
			int number=0;
			String sql="";
			try {
				conn=getConnection();
				pstmt = conn.prepareStatement("select max(num) from eboard");
				rs = pstmt.executeQuery();
				if(rs.next()) 		number=rs.getInt(1)+1;
				else 			number=1;
				
				//이 줄 이후 바뀐거 확인함
				ref=number;
				re_step=0;
				re_level=0;
				
				//혹시나해서 앞뒤로 띄워쓰기 추가해주고요 안 한거보다 나음
				sql="inset into eboard "
						+" (num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) "
						+" values (?,?,?,?,?,?,?,?,?,?,?)";
				//후자 수정중 16:28
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, number);
				pstmt.setString(2,article.getWriter());
				pstmt.setString(3,article.getEmail());
				pstmt.setString(4,article.getSubject());
				pstmt.setString(5,article.getPasswd());
				pstmt.setTimestamp(6,article.getRegDate());
				pstmt.setInt(7,article.getRef());
				pstmt.setInt(8,article.getReStep());
				pstmt.setInt(9,article.getReLevel());
				pstmt.setString(10,article.getContent());
				pstmt.setString(11,article.getIp());
				pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null)
					try {rs.close();} catch(SQLException e) {e.printStackTrace();}
				if(pstmt!=null)
					try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
				if(conn!=null)
					try {conn.close();} catch(SQLException e ) {e.printStackTrace();}
			}
		}
		//여기 try이는 전자랑 상관없이 conn때문 못 들음.응??
		
		public  List<BoardDataBean> getArticles(int start, int end) throws Exception{
			// 1.public int getArticleCoun가 전자로 수정됨.
		
			//이 전후 바뀐거 확인 설명 놓침  int x = 0;왜 있다가 없어짐
			//articleList = new ArrayList<BoardDataBean>(end); 왜 만들었는데요? 관련 내용 확인하기
			//do. 실행 후 다시 확인 쭉.. 응?
			Connection conn = null;
			PreparedStatement pstmt = null;
			//전자에 PreparedStatement ed 오타 조심
			ResultSet rs = null;
			String sql="";
			List<BoardDataBean> articleList = null; 
			//int x = 0;
			try {
				conn = getConnection();
				sql="select * from "
						+ " (select "
						+ " ROWNUM rnum,num,writer,email,subject,passwd,reg_date,readcount,ref,re_step,re_level,content,ip"
						+ " from "
						+ " (select * from eboard order by ref desc, re_step asc) "
						+ " eboard)"
						+ " where rnum>=? and rnum<=?";
				//sql="select * from eboard where num>=? and num <=?";가 전자로 바뀜
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if (rs.next())			/*x= rs.getInt(1);*/
					articleList = new ArrayList<BoardDataBean>(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setRegDate(rs.getTimestamp("reg_date"));
					article.setReadCount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setReStep(rs.getInt("re_step"));
					article.setReLevel(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				} while(rs.next());
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null) 
					try { rs.close(); } catch(SQLException e) {e.printStackTrace();}
				if (pstmt != null) 
					try { pstmt.close(); } catch(SQLException e) {e.printStackTrace();}
				if (conn != null) 
					try {conn.close(); } catch(SQLException e) {e.printStackTrace();}
			}
			return articleList;
			/*
			 * return x;
		*/
	}
		public  int getArticleCount() throws Exception {

			Connection conn = null;
			PreparedStatement pstmt = null;
			//전자에 PreparedStatement ed 오타 조심
			ResultSet rs = null;
			String sql=""; 
			int cnt=0;
			//int x = 0;
			try {
				conn = getConnection();
				sql="select count(*) from eboard";
				//	sql="select * from eboard where num>=? and num <=?";가 전자로 바뀜
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next())	{		/*x= rs.getInt(1);*/
					cnt=rs.getInt(1);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null) 
					try { rs.close(); } catch(SQLException e) {e.printStackTrace();}
				if (pstmt != null) 
					try { pstmt.close(); } catch(SQLException e) {e.printStackTrace();}
				if (conn != null) 
					try {conn.close(); } catch(SQLException e) {e.printStackTrace();}
			}
			return cnt;
			
	
		}
}
