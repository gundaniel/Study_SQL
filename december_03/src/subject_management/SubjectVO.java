package subject_management;

public class SubjectVO {

	private int no;
	private String s_num;
	private String s_name;
	
	//생성자 선언
	//디폴트를 만들어야 함
	public SubjectVO() {}
	
	public SubjectVO(String s_num,String s_name) {
		this(0, s_num,s_name);
	}

	public SubjectVO(int no, String s_num, String s_name) {
		this.no = no;
		this.s_num = s_num;
		this.s_name = s_name;
	}

	//설정자, 접근자 선언
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getS_num() {
		return s_num;
	}
	public void setS_num(String s_num) {
		this.s_num = s_num;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	
	//출력메서드 선언
	
	@Override
	public String toString() {
		return "Subject [no = " + no + ", s_num = " + s_num + ", s_name = " + s_name + "]";
	}
	
	
}
