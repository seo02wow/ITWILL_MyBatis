package com.mystudy.ajax.vo;

import java.sql.Date;

public class MemberVO {
	private int idx;
	private String name;
	private int age;
	private String addr;
	private Date regdate;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", name=" + name + ", age=" + age + ", addr=" + addr + ", regdate=" + regdate
				+ "]";
	}
	
	
}
