package board;

import java.sql.Timestamp;

public class BoardDataBean {
	private int num;
	private String writer;
	private String email;
	private String subject;
	private String passwd;
	private Timestamp regDate;
	private int readCount;
	private int ref;
	private int reStep;
	private int reLevel;
	private String content;
	private String ip;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getReStep() {
		return reStep;
	}
	public void setReStep(int reStep) {
		this.reStep = reStep;
	}
	public int getReLevel() {
		return reLevel;
	}
	public void setReLevel(int reLevel) {
		this.reLevel = reLevel;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	
	
	/*
	-------- -------- -------------- 
	NUM      NOT NULL NUMBER(4)      
	WRITER   NOT NULL VARCHAR2(10)   
	EMAIL             VARCHAR2(30)   
	SUBJECT  NOT NULL VARCHAR2(50)   
	PASSWD   NOT NULL VARCHAR2(12)   
	REG_DATE NOT NULL DATE           
	READCOUT          NUMBER(8)      
	REF      NOT NULL NUMBER(4)      
	RE_STEP  NOT NULL NUMBER(4)      
	RE_LEVEL NOT NULL NUMBER(4)      
	CONTENT  NOT NULL VARCHAR2(1000) 
	IP       NOT NULL VARCHAR2(20) 
	*/
}
