package exam_database;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.Scanner;



public class PrepareStatementTest {
	public static void main(String[]args) {
		Scanner input = new Scanner(System.in);
		String title, publisher, year;
		int price;
		
		System.out.println("북테이블 데잍터 입력 및 수정");
		
		System.out.print("책제목 입력");
		title = input.nextLine();
		System.out.println("출판사 입력");
		publisher = input.nextLine();
		System.out.println("출판연도 입력");
		year = input.nextLine();
		System.out.println("가격입력");
		price = input.nextInt();
		
		addbook(title,publisher,year,price);
		input.close();
	}
		
		
		private static void addbook(String title, String publisher, String year, int price) {
			
			//prepareStatement를 사용한 쿼리문 작성

			StringBuffer sb = new StringBuffer();
			sb.append("INSERT INTO books(book_id, title, publisher,year, price) ");
			sb.append("VALUES(books_seq.nextval,?,?,?,?)");
			
			try(Connection conn = ConnectionDatabase.getConnection ("xepdb1","javauser","java1234");
				PreparedStatement pstmt = conn.prepareStatement(sb.toString());){
				
				pstmt.setString(1,title);
				pstmt.setString(2,publisher);
				pstmt.setString(3,year);
				pstmt.setInt(4,price);
				
				int insertCount = pstmt.executeUpdate();
				
				if(insertCount == 1) {
					System.out.println("레코드 추가 성공");
					readAllbook();
				}
				else {
					System.out.println("레코드 추가 실패");
				}
			}
			catch(Exception e) {
				System.err.println("[쿼리문 ERROR]" + e.getMessage());
				e.printStackTrace();
			}
		}	
		
		private static void readAllbook() {
			StringBuffer sb = new StringBuffer();
			sb.append("select book_id, title, publisher,year,price ");
			sb.append("from books order by book_id");
			
			try(Connection conn = ConnectionDatabase.getConnection ("xepdb1","javauser","java1234");
					PreparedStatement pstmt = conn.prepareStatement(sb.toString());
				ResultSet rs = pstmt.executeQuery();){
					
					System.out.println("데이터 출력");
					System.out.printf("%s\t%-20s\t%6s\t%12s\t%s\n","책번호","책제목", "출판사", "출판연도", "가격");

		            while(rs.next()){
		                System.out.printf("%d\t", rs.getInt("book_id"));
		                System.out.printf("%-26s", rs.getString("title"));
		                System.out.printf("%-12s\t", rs.getString("publisher"));
		                System.out.printf("%s\t", rs.getString("year"));
		                System.out.printf("%d\n", rs.getInt("price"));
		            }
		        }
				catch (Exception e) {
		        	System.err.println("[쿼리문 ERROR] \n" + e.getMessage());
		        }
		    
		}
	}
						
						
