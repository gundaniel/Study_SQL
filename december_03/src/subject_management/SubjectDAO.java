package subject_management;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SubjectDAO {

		private static final String JDBC_URL = "jdbc:oracle:thin:@127.0.0.1:1521/xepdb1";
		private static final String USER = "javauser";
		private static final String PASSWD = "java1234";
		
		//칼래스 자신의 타입으로 정적 필드 선언
		private static SubjectDAO instance = null;
		
		//외부에서 호출할 수 있는 정적 메소드인 getInstance() 선언하여 인스턴스를 반환
		public static SubjectDAO getInstance() {
			if(instance == null) {
				instance = new SubjectDAO();
			}
			return instance;
		}
		 // 외부에서 new 연산자로 생성자를 호출할 수 없도록 막기 위해 접근 제한자(private) 설정
	    private SubjectDAO(){
	        try{
	            Class.forName("oracle.jdbc.driver.OracleDriver");
	        }catch(ClassNotFoundException cnfe){
	            cnfe.printStackTrace();
	        }
	    }

	    private Connection getConnection() throws SQLException{
	        Connection con = DriverManager.getConnection(JDBC_URL, USER, PASSWD);
	        return con;
	    }

	    public ArrayList<SubjectVO> getSubjectTotal(){
	        SubjectVO svo  = null;
	        ArrayList<SubjectVO> list = new ArrayList<SubjectVO>();
	        
	        StringBuffer sql = new StringBuffer();
	        sql.append("select no, s_num, s_name from subject ");
	        sql.append("order by no");
	        
	        try(Connection conn = getConnection();
	        	PreparedStatement pstmt = conn.prepareStatement(sql.toString());	
	        	ResultSet rs = pstmt.executeQuery();){

	            //ResultSet의 결과에서 모든 행을 각각의 SubjectVO 객체에 저장
	            while(rs.next()) {
	                //한 행의 학과 정보를 저장할 VO 객체 생성
	                svo = new SubjectVO();
	                //한 행의 학과 정보를 VO 객체에  저장
	                svo.setNo(rs.getInt("no"));
	                svo.setS_num(rs.getString("s_num"));
	                svo.setS_name(rs.getString("s_name"));

	                // ArrayList 객체에 원소로 추가
	                list.add(svo);
	            }
	        }catch(SQLException se) {
	            System.out.println("조회에 문제가 있어 잠시 후에 다시 진행해 주세요.");
	            se.printStackTrace();
	        }catch (Exception e){
	            System.err.println("error = [ "+e.getMessage()+" ]");
	        }
	        
	        return list;
	    }
	    
	    
	    public String getSubjectNum() {
	    String subjectNumber = "";
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append("SELECT nvl(to_char(max(s_sum)+1,'FM00'), '01'");
	    sql.append("as subjectNum from subject");
	    
	    try(Connection conn = getConnection();
	    	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	    		ResultSet rs = pstmt.executeQuery();
	    		){
	    	
	    	if(rs.next()) {
	    		subjectNumber =rs.getString("subectNum");
	    	}
	    }
	    catch (SQLException se) {
	    	System.err.println("쿼리 getSubjectNum error = [" +se.getMessage() + "]");
	    	se.printStackTrace();
	    }
	    catch (Exception e) {
	    	System.out.println("error = [" + e+ "]");
	    }
	    return subjectNumber;
	    }
	   
	    /***********************************************************
	     * subjectInsert() 메서드: 학과 테이블에 데이터 입력.
	     * @param svo SubjectVO 클래스
	     * @return boolean 자료형 리턴.
	     ***********************************************************/
	    
	    public boolean subjectInsert(SubjectVO svo) {
	        boolean success = false;
	        
	        StringBuffer sql = new StringBuffer();
	        sql.append("insert into subject(no, s_num, s_name) ");
	        sql.append("values(subject_seq.nextval, ?, ?)");

	        try (Connection conn = getConnection();
	        	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	        	) {
	      
	            pstmt.setString(1, svo.getS_num()); // 첫번째 ?(바인딩변수) 설정값 - 학과번호
	            pstmt.setString(2, svo.getS_name());// 두번째 ?(바인딩변수) 설정값 - 학과명

	            int i = pstmt.executeUpdate(); // 쿼리문 실행 - 결과값은 입력된 행의 수 반환.
	            if(i == 1) {
	                success = true;
	            }
	        }catch(SQLException se) {
	            System.out.println("입력에 문제가 있어 잠시 후에 다시 진행해 주세요.");
	            //se.printStackTrace(); 오류 발생 시 확인
	        }catch (Exception e){
	            System.err.println("error = [ "+e.getMessage()+" ]");
	        } 
	        return success;
	    }
	    
	    /***********************************************************
	     * subjectUpdate() 메서드: 학과 테이블에 데이터 수정. 학과번호는 수정할 수 없다
	     * @param  svo SubjectVO 클래스
	     * @return boolean 자료형 리턴.
	     **********************************************************/
	    public boolean subjectUpdate(SubjectVO svo) {
	        boolean success = false;

	        StringBuffer sql = new StringBuffer();
	        sql.append("update subject set s_name = ? ");
	        sql.append("where s_num = ?");

	        try (Connection conn = getConnection();
	        	 PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	        	){
	 
	            pstmt.setString(1, svo.getS_name());
	            pstmt.setString(2, svo.getS_num());

	            int i = pstmt.executeUpdate();
	            if(i == 1) {
	                success = true;
	            }
	        }catch(SQLException se) {
	            System.out.println("수정에 문제가 있어 잠시 후에 다시 진행해 주세요.");
	            se.printStackTrace();
	        }catch (Exception e){
	            System.out.println("error = [ "+e+" ]");
	        } 
	        return success;
	    }

	    /***********************************************************
	     * studentDataCheck() 메서드: 학과에 소속된 학생이 있는지 확인
	     * @return int 자료형 리턴.
	     ***********************************************************/
	    public int studentDataCheck(SubjectVO svo) {
	        StringBuffer  sql    = new StringBuffer();
	        sql.append("select count(sd_num) from student ");
	        sql.append("where s_num = ?");

	        ResultSet rs = null;
	        int data = 0;
	        try (Connection con = getConnection();
	        	 PreparedStatement pstmt = con.prepareStatement(sql.toString());
	        	){

	            pstmt.setString(1, svo.getS_num());
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                data = rs.getInt(1);
	            }
	        } catch (SQLException se) {
	            System.out.println("쿼리 studentDataCheck error = [ "+se+" ]");
	            se.printStackTrace();
	        } catch (Exception e) {
	            System.out.println("error = [ "+e+" ]");
	        } finally {
	            try {
	                if (rs != null) rs.close();
	            } catch (SQLException se) {
	                System.out.println("디비 연동 해제 error = [ "+se+" ]");
	            }
	        }
	        return data;
	    }

	    /***********************************************************
	     * subjectDelete() 메서드: 학과 테이블에 데이터 삭제. 소속된 학생이 존재하지 않을 경우만 삭제진행.
	     * @param  svo SubjectVO 클래스
	     * @return boolean 자료형 리턴.
	     **********************************************************/
	    public boolean subjectDelete(SubjectVO svo) {
	        boolean success = false;

	        StringBuffer sql = new StringBuffer();
	        sql.append("delete from subject where s_num = ?");
	        try(Connection conn = getConnection();
	        	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	        	) {

	            pstmt.setString(1, svo.getS_num());

	            int i = pstmt.executeUpdate();
	            if(i == 1) {
	                success = true;
	            }
	        }catch(SQLException se) {
	            System.out.println("삭제에 문제가 있어 잠시 후에 다시 진행해 주세요.");
	            se.printStackTrace();
	        }catch (Exception e){
	            System.out.println("error = [ "+e+" ]");
	        } 
	        return success;
	    }
	    /***********************************************************
	     * getSubjectSearch() 메서드: 학과명 검색.
	     * @param  학과명
	     * @return ArrayList<SubjectVO> 자료형 리턴.
	     * 참고사항: 추후 검색부분은 전체 조회 메서드에서 같이 처리하도록 수정한다.
	     **********************************************************/
	    public ArrayList<SubjectVO> getSubjectSearch(String s_name) {
	        ResultSet rs = null;
	        SubjectVO svo = null;
	        ArrayList<SubjectVO> list = new ArrayList<SubjectVO>();

	        StringBuffer sql = new StringBuffer();
	        sql.append("select no, s_num, s_name from subject ");
	        sql.append("where s_name like ? ");
	        sql.append("order by no");

	        try (Connection conn = getConnection();
	        	 PreparedStatement	pstmt = conn.prepareStatement(sql.toString());	
	        	) {
	  
	            pstmt.setString(1, "%" + s_name + "%");

	            rs = pstmt.executeQuery();
	            while(rs.next()){
	                svo = new SubjectVO();
	                svo.setNo(rs.getInt("no"));
	                svo.setS_num(rs.getString("s_num"));
	                svo.setS_name(rs.getString("s_name"));

	                list.add(svo);
	            }
	        }catch(SQLException se) {
	            System.out.println("검색에 문제가 있어 잠시 후에 다시 진행해 주세요.");
	            se.printStackTrace();
	        }catch (Exception e){
	            System.out.println("error = [ "+e+" ]");
	        } finally{
	            try{
	                if (rs != null) rs.close();
	            }catch(SQLException e){
	                System.out.println("디비 연동 해제 error = [ "+e+" ]");
	            }
	        }
	        return list;
	    }
	} // 클래스 종료.
	    
	
		
	
