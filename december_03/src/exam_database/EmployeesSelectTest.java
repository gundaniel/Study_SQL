package exam_database;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeesSelectTest {
	public static void main(String[]args) {
		int employee_id, salary;
		String first_name, hire_date;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = ConnectionDatabase.getConnection("xe","hr","hr1234");
			stmt = conn.createStatement();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT employee_id, first_name, salary, ");
			sql.append("to_char(hire_date, 'YYYY-MM-DD')hire_date ");
			sql.append("FROM employees");
			rs = stmt.executeQuery(sql.toString());
		
			System.out.println(" **** EMPLOYEES 테이블 데이터 출력 **** \n");
			System.out.printf("%s\t%s\t%6s\t%8s\n","사원번호","사원이름","급여","입사일");
		
			while (rs.next()) {
				employee_id = rs.getInt("employee_id");
				first_name =rs.getString("first_name");
				salary = rs.getInt("salary");
				hire_date = rs.getString("hire_date");
				
				System.out.printf("%-7d %-11s %-6d %s\n",employee_id, first_name, salary, hire_date);
			}
		}catch(Exception s){
			System.err.println("[쿼리문 ERROR] \n" + s.getMessage());
		}finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}catch(SQLException sqle) {
				System.out.println("ClOSE ERROR");
			}
		
		}
	}
}