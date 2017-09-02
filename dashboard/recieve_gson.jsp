<%@page import="java.sql.*"%>
<%@page import="javax.swing.JTextField" %>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="com.google.gson.Gson.*"%>
<%@ page import="com.google.gson.annotations.Expose"%>
 <%@ page import=" com.google.gson.annotations.SerializedName;" %>
<%
//out.println("Pass");
String uidd = request.getParameter("nid");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
//Vector disid=new Vector();
int ct=0;

try 
{
Class.forName(driverName);
} 
catch (ClassNotFoundException e)
{
    //out.println(e);
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null,rs=null;
PreparedStatement prs;

    %>
    <%
    class Patient {

    	@SerializedName("appdate")
    	@Expose
    	private String appdate;
    	@SerializedName("illnessID")
    	@Expose
    	private String illnessID;
    	@SerializedName("dob")
    	@Expose
    	private String dob;
    	@SerializedName("gender")
    	@Expose
    	private String gender;
    	@SerializedName("nurseid")
    	@Expose
    	private String nurseid;
    	@SerializedName("pid")
    	@Expose
    	private String pid;
    	@SerializedName("name")
    	@Expose
    	private String name;
    	@SerializedName("repdate")
    	@Expose
    	private String repdate;
    	@SerializedName("repmaxscore")
    	@Expose
    	private String repmaxscore;
    	@SerializedName("repscore")
    	@Expose
    	private String repscore;
    	@SerializedName("status")
    	@Expose
    	private String status;
    	@SerializedName("surveydesc")
    	@Expose
    	private String surveydesc;
    	@SerializedName("surveyid")
    	@Expose
    	private String surveyid;
    	@SerializedName("surveyname")
    	@Expose
    	private String surveyname;

    	public String getAppdate() {
    	return appdate;
    	}

    	public void setAppdate(String appdate) {
    	this.appdate = appdate;
    	}

    	public String getIllnessID() {
    	return illnessID;
    	}

    	public void setIllnessID(String illnessID) {
    	this.illnessID = illnessID;
    	}

    	public String getDob() {
    	return dob;
    	}

    	public void setDob(String dob) {
    	this.dob = dob;
    	}

    	public String getGender() {
    	return gender;
    	}

    	public void setGender(String gender) {
    	this.gender = gender;
    	}

    	public String getNurseid() {
    	return nurseid;
    	}

    	public void setNurseid(String nurseid) {
    	this.nurseid = nurseid;
    	}

    	public String getPid() {
    	return pid;
    	}

    	public void setPid(String pid) {
    	this.pid = pid;
    	}

    	public String getName() {
    	return name;
    	}

    	public void setName(String name) {
    	this.name = name;
    	}

    	public String getRepdate() {
    	return repdate;
    	}

    	public void setRepdate(String repdate) {
    	this.repdate = repdate;
    	}

    	public String getRepmaxscore() {
    	return repmaxscore;
    	}

    	public void setRepmaxscore(String repmaxscore) {
    	this.repmaxscore = repmaxscore;
    	}

    	public String getRepscore() {
    	return repscore;
    	}

    	public void setRepscore(String repscore) {
    	this.repscore = repscore;
    	}

    	public String getStatus() {
    	return status;
    	}

    	public void setStatus(String status) {
    	this.status = status;
    	}

    	public String getSurveydesc() {
    	return surveydesc;
    	}

    	public void setSurveydesc(String surveydesc) {
    	this.surveydesc = surveydesc;
    	}

    	public String getSurveyid() {
    	return surveyid;
    	}

    	public void setSurveyid(String surveyid) {
    	this.surveyid = surveyid;
    	}

    	public String getSurveyname() {
    	return surveyname;
    	}

    	public void setSurveyname(String surveyname) {
    	this.surveyname = surveyname;
    	}

    	}




    	class Question {
    	@SerializedName("answer")
    	@Expose
    	private String answer;
    	@SerializedName("maxscore")
    	@Expose
    	private String maxscore;
    	@SerializedName("pid")
    	@Expose
    	private String pid;
    	@SerializedName("qdesc")
    	@Expose
    	private String qdesc;
    	@SerializedName("qid")
    	@Expose
    	private String qid;
    	@SerializedName("score")
    	@Expose
    	private String score;

    	public String getAnswer() {
    	return answer;
    	}

    	public void setAnswer(String answer) {
    	this.answer = answer;
    	}

    	public String getMaxscore() {
    	return maxscore;
    	}

    	public void setMaxscore(String maxscore) {
    	this.maxscore = maxscore;
    	}

    	public String getPid() {
    	return pid;
    	}

    	public void setPid(String pid) {
    	this.pid = pid;
    	}

    	public String getQdesc() {
    	return qdesc;
    	}

    	public void setQdesc(String qdesc) {
    	this.qdesc = qdesc;
    	}

    	public String getQid() {
    	return qid;
    	}

    	public void setQid(String qid) {
    	this.qid = qid;
    	}

    	public String getScore() {
    	return score;
    	}

    	public void setScore(String score) {
    	this.score = score;
    	}

    	}
        class Example {

            @SerializedName("Patient")
            @Expose
            private List<Patient> patient = null;
            @SerializedName("Questions")
            @Expose
            private List<Question> questions = null;
            @SerializedName("id")
            @Expose
            private Integer id;

            public List<Patient> getPatient() {
            return patient;
            }

            public void setPatient(List<Patient> patient) {
            this.patient = patient;
            }

            public List<Question> getQuestions() {
            return questions;
            }

            public void setQuestions(List<Question> questions) {
            this.questions = questions;
            }

            public Integer getId() {
            return id;
            }

            public void setId(Integer id) {
            this.id = id;
            }

            }
    %>
  