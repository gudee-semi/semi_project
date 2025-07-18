document.addEventListener("DOMContentLoaded", function () {
		
	dayjs.locale('ko');
	// 오늘 날짜
	const now = dayjs();  
	
	
	// 시험 일정 배열
	// 다가오는 모의고사 일정
	const testDates = [
	  { label: "3월 모의고사", date: dayjs('2025-03-26'), type: "모의고사" },
	  { label: "6월 모의고사", date: dayjs('2025-06-04'), type: "모의고사" },
	  { label: "9월 모의고사", date: dayjs('2025-09-03'), type: "모의고사" }
	];
	
	// 학년별 수능 일정
	const 수능 = {
	  1: { label: "2027 대학수학능력시험", date: dayjs('2027-11-18'), type: "수능" },
	  2: { label: "2026 대학수학능력시험", date: dayjs('2026-11-19'), type: "수능" },
	  3: { label: "2025 대학수학능력시험", date: dayjs('2025-11-13'), type: "수능" }
	};

	// 로그로 확인
    console.log("오늘 날짜:", now.format());
    console.log("학생 학년:", studentGrade);
    testDates.forEach(t => {
      console.log(t.label, t.date.format(), t.date.isAfter(now));
    });
    
    
	const container = document.getElementById("dday-wrapper");
	
	
	// 가장 가까운 모의고사 시험 찾기
	const upcoming = testDates.find(t => t.date.isAfter(now));
	 if (upcoming) {
	   const dday = upcoming.date.diff(now, 'day');
	   const formatted = upcoming.date.format('YYYY년 M월 D일');
	   const ddayText = (dday === 0) ? 'D-Day' : `D-${dday}`;
	
	   const card = document.createElement("div");
	   card.className = "dday-card";
	   card.innerHTML = `
	     <div class="dday-top">
	       <span>${formatted}</span>
	       <span>시험까지</span>
	     </div>
	     <div class="dday-main">
	       <span class="dday-title">다음 시험: ${upcoming.label}</span>
	       <span class="dday-value">${ddayText}</span>
	     </div>
	   `;
	   container.appendChild(card);
	}
	
	// 수능 카드 - 항상 표시
	const csat = 수능[studentGrade];
	 if (csat) {
	   const dday = csat.date.diff(now, 'day');
	   const formatted = csat.date.format('YYYY년 M월 D일');
	   const ddayText = (dday === 0) ? 'D-Day' : `D-${dday}`;
	
	   const card = document.createElement("div");
	   card.className = "dday-card";
	   card.innerHTML = `
	     <div class="dday-top">
	       <span>${formatted}</span>
	       <span>시험까지</span>
	     </div>
	     <div class="dday-main">
	       <span class="dday-title">${csat.label}</span>
	       <span class="dday-value">${ddayText}</span>
	     </div>
	   `;
	   container.appendChild(card);
	   }
	});
