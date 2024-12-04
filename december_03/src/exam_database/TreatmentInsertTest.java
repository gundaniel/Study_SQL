package exam_database;

import java.sql.Statement;
import java.sql.Connection;
import java.util.Scanner;

public class TreatmentInsertTest {
	public static void main(String[] args) {
		Connection conn = null;
		Statement stmt = null;

		/*
		 * 진료과목 테이블에 데이터 입력, 직접 값을 명시하여 데이터 입력 try { conn =
		 * ConnectionDatabase.getConnection("xe","hr","hr1234"); stmt =
		 * conn.createStatement();
		 * 
		 * StringBuffer sb = new StringBuffer();
		 * sb.append("INSERT INTO treatment(t_no, t_course_abbr, t_course,t_tel)");
		 * sb.append("VALUES(1004, 'GS', '일반외과', '02-3452-4001')");
		 * 
		 * int insertCount = stmt.executeUpdate(sb.toString());
		 * 
		 * if(insertCount == 1) { System.out.println("레코드 추가 성공"); }else {
		 * System.out.println("레코드 추가 실패"); } } catch(Exception e) {
		 * System.err.println("[쿼리문 ERROR] \n" + e.getMessage()); } finally { try {
		 * if(stmt != null) stmt.close(); if(conn != null) conn.close(); }
		 * catch(Exception en){ en.printStackTrace(); } }
		 */

		// 값을 입력받아 데이터 입력
		String courseAbbr, course, tel;
		int no;

		Scanner input = new Scanner(System.in);
		System.out.println("진료번호, 진료과목 약어, 진료과목, 전화번호를 순서대로 입력해주세요");
		no = input.nextInt();
		courseAbbr = input.next();
		course = input.next();
		tel = input.next();
		input.close();

		try {
			conn = ConnectionDatabase.getConnection("xe", "hr", "hr1234");
			stmt = conn.createStatement();

			StringBuffer sb = new StringBuffer();
			sb.append("INSERT INTO treatment(t_no, t_course_abbr, t_course,t_tel)");
			sb.append("VALUES (" + no + ", '" + courseAbbr + "','" + course);
			sb.append("','" + tel + "')");

			int insertCount = stmt.executeUpdate(sb.toString());

			if (insertCount == 1) {
				System.out.println("레코드 추가 성공");
			} else {
				System.out.println("레코드 추가 실패");
			}
		} catch (Exception e) {
			System.err.println("[쿼리문 ERROR] \n" + e.getMessage());
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception en) {
				en.printStackTrace();
			}
		}

	}

}
