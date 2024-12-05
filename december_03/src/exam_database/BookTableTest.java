package exam_database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class BookTableTest {
	public static Scanner input = new Scanner(System.in);	
	
	public static void showMenu() {
		String menu = """
				선택하세요...
				1. 데이터 입력
				2. 데이터 검색
				3. 데이터 삭제
				4. 프로그램 종료
				""";
		System.out.println(menu);
		System.out.println("선택: ");
	}
	
	public static void main(String[]args) {
		int choice;
		
		while (true) {
			showMenu();
			choice = input.nextInt();
			input.nextLine();
			
			switch(choice) {
			case 1: 
				addBook();
				break;
			case 2:
				readbook();
				break;
			case 3:
				deletebook();
				break;
			case 4:
				System.out.println("프로그램을 종료합니다.");
				return;
			}
		}
	}
	
	
	private static void addBook() {
		int price;
		String title, publisher, year;
		
		System.out.println("책이름, 출판사, 출간연도, 가격을 순서대로 입력해주세요");
		title = input.next();
		publisher = input.next();
		year = input.next();
		price = input.nextInt();
		
		try (Connection conn = ConnectionDatabase.getConnection("xepdb1","javauser","java1234");
				Statement stmt = conn.createStatement();){
						
			StringBuffer sb = new StringBuffer();
			sb.append("INSERT INTO books(book_id, title, publisher, ");
			sb.append("year, price) VALUES(books_seq.nextval,");
			sb.append("'" + title + "','" + publisher + "','");
			sb.append(year + "'," + price + ")");
			
			System.out.println("쿼리문 확인: " + sb);
			
			int insertCount = stmt.executeUpdate(sb.toString());
			
			if(insertCount == 1) {
				System.out.println("레코드 추가 성공");
			}else {
				System.out.println("레코드 추가 실패");
			}
		}
		catch(Exception e) {
			System.err.println("[쿼리문 ERROR \n]" + e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	private static void readbook() {
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT book_id,title, publisher, ");
		sql.append("year, price ");
		sql.append("FROM books");
		
		try (Connection conn = ConnectionDatabase.getConnection("xepdb1","javauser","java1234");
				Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql.toString());){

			int book_id,price;
			String title, publisher,year;
	
			sql.append("SELECT book_id,title, publisher, ");
			sql.append("year, price ");
			sql.append("FROM books");
			
			System.out.println("출력");
			
			while(rs.next()) {
				book_id = rs.getInt("book_id");
				title = rs.getString("title");
				publisher = rs.getString("publisher");
				year = rs.getString("year");
				price = rs.getInt("price"); 
				
				System.out.println(book_id + ", " + title + ", " +publisher+ ", " + year + ", "  + price);
				}
		}		
		catch(Exception e) {
			System.out.println("[쿼리문 ERROR] \n" + e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	private static void deletebook() {
		System.out.println("삭제할 책 번호를 입력해주세요");
		int book_id = input.nextInt();
		input.nextLine();
		
		try (Connection conn = ConnectionDatabase.getConnection("xepdb1","javauser","java1234");
				Statement stmt = conn.createStatement();){
			
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM books where booK_id = " + book_id);
			
			int deleteCount = stmt.executeUpdate(sql.toString());
			if(deleteCount == 1) {
				System.out.println("레코드 삭제성공");
			}
			else {
				System.out.println("레코드 삭제 실패");
			}
		}
		catch(Exception e) {
			System.out.println("[쿼리문 ERROR] \n" + e.getMessage());
			e.printStackTrace();
		}
	}
	
}

	
