package com.hy.common.vo;

public class Paging {
	// 1. 전체 게시글 개수
	private int totalData;
	
	// 2. 전체 페이지 개수
	private int totalPage;
	
	// 3. 페이징바 구성에 필요한 정보
	// (1) 페이징바 크기
	private int pageBarSize = 10;
	// (2) 현재 페이징바 시작 숫자
	private int pageBarStart; // 1, 6, 11, ...
	// (3) 현재 페이징바 마지막 숫자
	private int pageBarEnd; // 5, 10, 15, ...
	
	// 4. 현재 페이지
	private int nowPage;
	// 5. 한 페이지당 게시글의 개수
	private int numPerPage = 10;
	// 6. LIMIT 시작 번호
	private int limitPageNo;
	
	// 7. 이전, 다음 화살표 존재 여부
	private boolean prev = true;
	private boolean next = true;
	
	public void setTotalData(int totalData) {
		this.totalData = totalData;
		calcPaging();
	}
	
	public Paging() {}
	
	private void calcPaging() {
		// setTotalData 메소드 호출 전에 nowPage 정보 셋팅
		// 1. 현재 페이지를 기준으로 건너뛸 데이터의 개수
		limitPageNo = (nowPage-1)*numPerPage;
		// 2. 전체 게시글 개수(totalData) 기준으로 전체 페이지 개수 계산(totalPage)
		totalPage = (int)Math.ceil((double)totalData / numPerPage);
		// 3. 페이징바 시작 번호 계산
		pageBarStart = ((nowPage-1)/pageBarSize)*pageBarSize + 1;
		// 4. 페이징바 끝번호 계산
		pageBarEnd = pageBarStart + pageBarSize -1;
		// 만일 끝 번호가 전체 페이지 개수보다 크면 재할당
		if(pageBarEnd > totalPage) pageBarEnd = totalPage;
		// 5. 이전, 이후 버튼이 보이는지 여부
		if(pageBarStart == 1) prev = false;
		if(pageBarEnd >= totalPage) next = false;
	}
	public int getTotalData() {
		return totalData;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageBarSize() {
		return pageBarSize;
	}
	public void setPageBarSize(int pageBarSize) {
		this.pageBarSize = pageBarSize;
	}
	public int getPageBarStart() {
		return pageBarStart;
	}
	public void setPageBarStart(int pageBarStart) {
		this.pageBarStart = pageBarStart;
	}
	public int getPageBarEnd() {
		return pageBarEnd;
	}
	public void setPageBarEnd(int pageBarEnd) {
		this.pageBarEnd = pageBarEnd;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getLimitPageNo() {
		return limitPageNo;
	}
	public void setLimitPageNo(int limitPageNo) {
		this.limitPageNo = limitPageNo;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
	// 한 줄 주석: 현재 페이지, 전체 데이터 수, 한 페이지당 개수로 초기화
	public Paging(int nowPage, int totalData, int numPerPage) {
	    this.nowPage = nowPage;
	    this.numPerPage = numPerPage;
	    setTotalData(totalData); // 전체 개수 세팅하면서 자동으로 calcPaging 호출됨
	}
}
