package board;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;


public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();

	private BoardDBBean() {}

	public static BoardDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		Context envContext= (Context)initContext.lookup("java:comp/env");
		DataSource ds= (DataSource)envContext.lookup("jdbc/oracle");	
		return ds.getConnection();
	}
	
	@SuppressWarnings("resource")
	public void insertArticle(BoardDataBean article) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
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
			if(rs.next())				number=rs.getInt(1)+1;
			else				number=1;
			if(num!=0) { //댓글
				sql="update eboard set re_step=re_step+1 where ref=? and re_step>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				
				re_step = re_step+1;
				re_level = re_level+1;
			} else { // 새글
				ref=number;
				re_step=0;
				re_level=0;
			}
			sql="insert into eboard "
					+ " (num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,filename, filesize,ip)"
					+ " values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,number);
			pstmt.setString(2,article.getWriter());
			pstmt.setString(3,article.getEmail());
			pstmt.setString(4,article.getSubject());
			pstmt.setString(5,article.getPasswd());
			pstmt.setTimestamp(6,article.getRegDate());
			pstmt.setInt(7,ref);
			pstmt.setInt(8,re_step);
			pstmt.setInt(9,re_level);
			pstmt.setString(10,article.getContent());
			pstmt.setString(11,article.getFilename());
			pstmt.setLong(12,article.getFilesize());
			pstmt.setString(13,article.getIp());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt!=null)
				try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn!=null)
				try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	public List<BoardDataBean> getArticles(int start, int end) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		List<BoardDataBean> articleList = null;
        try {
			conn=getConnection();
			sql="select * from "
					+ " (select "
					+ " ROWNUM rnum,num,writer,email,subject,passwd,reg_date,"
					+ " readcount,ref,re_step,re_level,content,ip "
					+ " from "
					+ " (select * from eboard order by ref desc, re_step asc) "
					+ " eboard)"
					+ " where rnum>=? and rnum<=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			if(rs.next()) {
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
			}					
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt!=null)
				try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn!=null)
				try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
        return articleList;
	}
	public int getArticleCount() throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int cnt=0;
        try {
			conn=getConnection();
			sql="select count(*) from eboard";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt(1);
			}
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	if(rs!=null) try {rs.close();} catch(SQLException e) { e.printStackTrace(); }
        	if(pstmt!=null) try {pstmt.close();} catch(SQLException e) { e.printStackTrace(); }
        	if(conn!=null) try {conn.close();} catch(SQLException e) { e.printStackTrace(); }
        }
        return cnt;
	}
	public BoardDataBean getArticle(int num) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		BoardDataBean article=null;
        try {
			conn=getConnection();
			
			sql="update eboard set readcount=readcount+1 where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		
			sql="select * from eboard where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDataBean();
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
                article.setFilename(rs.getString("filename"));
                article.setFilesize(rs.getLong("filesize"));
			    article.setIp(rs.getString("ip")); 
			}
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	if(rs!=null) try {rs.close();} catch(SQLException e) { e.printStackTrace(); }
        	if(pstmt!=null) try {pstmt.close();} catch(SQLException e) { e.printStackTrace(); }
        	if(conn!=null) try {conn.close();} catch(SQLException e) { e.printStackTrace(); }
        }
        return article;
	}
	public BoardDataBean updateGetArticle(int num) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		BoardDataBean article=null;
        try {
			conn=getConnection();

			sql="select * from eboard where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDataBean();
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
			}
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	if(rs!=null) try {rs.close();} catch(SQLException e) { e.printStackTrace(); }
        	if(pstmt!=null) try {pstmt.close();} catch(SQLException e) { e.printStackTrace(); }
        	if(conn!=null) try {conn.close();} catch(SQLException e) { e.printStackTrace(); }
        }
        return article;
	}
	
	public int updateArticle(BoardDataBean article) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String dbpasswd=""; 
        String sql="";
        int result=-1;
        try {
			conn=getConnection();
			pstmt = conn.prepareStatement("select passwd from eboard where num=?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.contentEquals(article.getPasswd())) {
					// update
					sql="update eboard set writer=?, email=?, subject=?, content=?,REG_DATE=?,ip=? "
							+ " where num=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1,article.getWriter());
					pstmt.setString(2,article.getEmail());
					pstmt.setString(3,article.getSubject());
					pstmt.setString(4,article.getContent());
					pstmt.setTimestamp(5,article.getRegDate());
					pstmt.setString(6,article.getIp());
					pstmt.setInt(7,article.getNum());
					pstmt.executeUpdate();
					result = 1;
				}
				else {
					result = 0;
				}
			}
    	} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt!=null)
				try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn!=null)
				try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
        return result;
	}
	
	public int deleteArticle(int num, String passwd) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
        String sql="";
		String dbpasswd=""; 
        int result=-1;
        if (passwd.length() > 12) {
        	return 2;
        }
        try {
			conn=getConnection();
			pstmt = conn.prepareStatement("select passwd from eboard where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.contentEquals(passwd)) {
					// delete
					sql="delete from eboard where num=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1,num);
					pstmt.executeUpdate();
					result = 1;
				}
				else {
					result = 0;
				}
			}
    	} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt!=null)
				try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn!=null)
				try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
        return result;
	}

	public static String replace(String str, String pattern, String replace) {
		int s = 0, e = 0;
		StringBuffer result = new StringBuffer();

		while ((e = str.indexOf(pattern, s)) >= 0) {
			result.append(str.substring(s, e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));
		return result.toString();
	}
	public static void delete(String s) {
		File file = new File(s);
		if (file.isFile()) {
			file.delete();
		}
	}
	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"), "ksc5601");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	//파일 다운로드
	public void downLoad(HttpServletRequest req, HttpServletResponse res,
			JspWriter out, PageContext pageContext) {
		String  SAVEFOLDER = req.getSession().getServletContext().getRealPath("/FileUpload");
		//String SAVEFOLDER="C:/z_ejkim/java_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ECh13_20190820/FileUpload";
	  try {
	    String filename = req.getParameter("filename");
	    File file = new File(con(SAVEFOLDER + File.separator+ filename));
	    byte b[] = new byte[(int) file.length()];
	    res.setHeader("Accept-Ranges", "bytes");
	    String strClient = req.getHeader("User-Agent");
	    if (strClient.indexOf("MSIE6.0") != -1) {
	      res.setContentType("application/smnet;charset=euc-kr");
	      res.setHeader("Content-Disposition", "filename=" + filename + ";");
	    } else {
	      res.setContentType("application/smnet;charset=euc-kr");
	      res.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
	    }
	    out.clear();
	    out = pageContext.pushBody();
	    if (file.isFile()) {
	      BufferedInputStream fin = new BufferedInputStream(
	          new FileInputStream(file));
	      BufferedOutputStream outs = new BufferedOutputStream(
	          res.getOutputStream());
	      int read = 0;
	      while ((read = fin.read(b)) != -1) {
	        outs.write(b, 0, read);
	      }
	      outs.close();
	      fin.close();
	    }
	  } catch (Exception e) {
	    e.printStackTrace();
	  }
	}

	
}




















