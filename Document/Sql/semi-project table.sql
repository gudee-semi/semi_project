-- 1. 데이터베이스 생성 및 진입
CREATE DATABASE semi_project;
USE semi_project;
-- 2. 회원(user) 테이블 생성 및 샘플 데이터 삽입
CREATE TABLE user (
	user_no INT UNSIGNED AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
	user_rrn VARCHAR(255) NOT NULL UNIQUE,
    user_seat INT UNSIGNED NOT NULL,
    PRIMARY KEY (user_no)
);
-- 3. member 테이블 생성 및 관리자 데이터 + 샘플 데이터 삽입
CREATE TABLE member (
	member_no INT UNSIGNED AUTO_INCREMENT,
    user_no INT UNSIGNED NOT NULL,
    member_id VARCHAR(50) UNIQUE NOT NULL,
    member_name VARCHAR(20) NOT NULL,
    member_pw VARCHAR(255) NOT NULL,
    member_phone VARCHAR(20) UNIQUE,
    member_rrn VARCHAR(255) UNIQUE,
    member_address VARCHAR(255),
    member_school VARCHAR(20),
    member_grade INT UNSIGNED,
    member_seat INT,
    member_penalty INT UNSIGNED DEFAULT 0,
    registered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (member_no),
    FOREIGN KEY (user_no) REFERENCES user (user_no) ON DELETE CASCADE
);
-- 3. 회원 프로필 사진 테이블 생성 및 샘플 데이터 삽입
CREATE TABLE member_avatar (
	avatar_id INT UNSIGNED AUTO_INCREMENT,
    member_no INT UNSIGNED UNIQUE NOT NULL,
	ori_name VARCHAR(255) NOT NULL,           
	re_name VARCHAR(255) NOT NULL,  
	path VARCHAR(255) NOT NULL,
    PRIMARY KEY (avatar_id),
    FOREIGN KEY (member_no) REFERENCES member (member_no) ON DELETE CASCADE
);

-- 시험 분류 테이블 생성
CREATE TABLE exam_type (
    exam_type_id INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,  -- 시험 분류 ID
    member_grade INT UNSIGNED NOT NULL,  -- 학년(1학년, 2학년, 3학년)
    exam_type INT UNSIGNED NOT NULL  -- 시험 분류(3월, 6월, 9월, 11월(수능))
);
-- 과목 분류 테이블(subject_type) 생성
CREATE TABLE subject (
    subject_id INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,  -- 과목 분류 ID
    subject_type VARCHAR(50) NOT NULL, -- 과목 타입(필수과목, 사회탐구, 과학탐구1, 과학탐구2, 제2외국어어)
    subject_name VARCHAR(50) NOT NULL
    /* 과목명(필수과목 : 국어, 수학, 영어, 한국사
            사회탐구 : 경제, 사회문화, 법과정치, 윤리와 사상, 세계지리, 한국지리, 세계사, 동아시아사, 생활과 윤리
            과학탐구1 : 물리1, 화학1, 생명과학1, 지구과학1
            과학탐구2 : 물리2, 화학2, 생명과학2, 지구과학2
            제2외국어 : 독일어, 프랑스어, 스페인어, 중국어, 일본어, 러시아어, 아랍어, 베트남어, 한문문    )*/
);

-- 목표 성적 테이블 생성
CREATE TABLE goal_score (
    goal_score_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,     -- 목표 성적 고유 ID
    member_no INT UNSIGNED NOT NULL,                           -- 회원 번호(member 테이블 참조)
    exam_type_id INT UNSIGNED NOT NULL,                        -- 시험 분류(exam_type 참조)
    subject_id INT UNSIGNED NOT NULL,                          -- 과목(subject 테이블 참조)
    target_score INT UNSIGNED NOT NULL,                        -- 목표 원점수 (0~100)
    target_level INT UNSIGNED NOT NULL,                        -- 목표 등급 (1~9)
    FOREIGN KEY (member_no) REFERENCES member(member_no) ON DELETE CASCADE,
    FOREIGN KEY (exam_type_id) REFERENCES exam_type(exam_type_id),
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);
-- 실제 성적 테이블 생성
CREATE TABLE actual_score (
    actual_score_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,   -- 실제 성적 고유 ID
    member_no INT UNSIGNED NOT NULL,                           -- 회원 번호
    exam_type_id INT UNSIGNED NOT NULL,                        -- 시험 분류
    subject_id INT UNSIGNED NOT NULL,                          -- 과목
    actual_score INT UNSIGNED NOT NULL,                        -- 실제 원점수
    actual_level INT UNSIGNED NOT NULL CHECK (actual_level BETWEEN 1 AND 9),  -- 등급 (1~9)
    actual_percentage DECIMAL(5,2) CHECK (actual_percentage BETWEEN 0 AND 100),  -- 백분위
    actual_rank VARCHAR(30),                                   -- 석차 (예: "123/421")
    FOREIGN KEY (member_no) REFERENCES member(member_no) ON DELETE CASCADE,
    FOREIGN KEY (exam_type_id) REFERENCES exam_type(exam_type_id),
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

-- 할 일 목록 테이블 생성
CREATE TABLE planner (
	planner_id INT UNSIGNED AUTO_INCREMENT,
    member_no INT UNSIGNED NOT NULL,
	title VARCHAR(50) NOT NULL,
    detail TEXT,
    is_completed INT UNSIGNED NOT NULL DEFAULT 0,
    due_date DATE NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (planner_id),
    FOREIGN KEY (member_no) REFERENCES member (member_no) ON DELETE cascade
);

-- [질의응답 테이블] 생성
CREATE TABLE qna (
	qna_id INT UNSIGNED AUTO_INCREMENT,
    member_no INT UNSIGNED NOT NULL,
    category VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT NOT NULL,
    reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mod_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    visibility INT NOT NULL DEFAULT 1,
    view_count INT NOT NULL DEFAULT 0,
    answer_status INT NOT NULL DEFAULT 0,
    PRIMARY KEY (qna_id),
    FOREIGN KEY (member_no) REFERENCES member (member_no) ON DELETE CASCADE
);

-- [질의응답 답변 테이블] 생성
CREATE TABLE qna_reply (
	qna_reply_id INT UNSIGNED AUTO_INCREMENT,
	qna_id INT UNSIGNED,
    content LONGTEXT NOT NULL,
    reply_check INT NOT NULL DEFAULT 1,  -- 회원이 확인 했는지 여부
    reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mod_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (qna_reply_id),
    FOREIGN KEY (qna_id) REFERENCES qna (qna_id) ON DELETE CASCADE
);

-- [질의응답 첨부파일 테이블] 생성
CREATE TABLE qna_attach (
	qna_attach_id INT UNSIGNED AUTO_INCREMENT,
	qna_id INT UNSIGNED NOT NULL,
    ori_name VARCHAR(255) NOT NULL,
    re_name VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    PRIMARY KEY (qna_attach_id),
    FOREIGN KEY (qna_id) REFERENCES qna (qna_id) ON DELETE CASCADE
);
-- [테블릿 테이블] 생성
CREATE TABLE tablet (
	tablet_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    member_no INT UNSIGNED NULL,
    tablet_available INT NOT NULL DEFAULT '0',
	FOREIGN KEY (member_no) REFERENCES member(member_no) ON DELETE CASCADE
);
-- [테블릿 로그 테이블] 생성
CREATE TABLE tablet_log (
	tablet_log_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    member_no INT UNSIGNED NOT NULL,
    use_time DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    tablet_status INT NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member(member_no) ON DELETE CASCADE
);
-- [좌석 테이블] 생성
CREATE TABLE seat (
	seat_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    member_no INT UNSIGNED,
    seat_status int NOT NULL,
    primary key (seat_id),
    foreign key (member_no) references MEMBER (member_no) ON DELETE CASCADE
);
-- [고정 좌석 테이블] 생성
CREATE TABLE fixed_seat (
    member_no INT UNSIGNED PRIMARY KEY,  -- :흰색_확인_표시: PK
    seat_no INT UNSIGNED UNIQUE,
    FOREIGN KEY (member_no) REFERENCES member(member_no) ON DELETE CASCADE  -- :흰색_확인_표시: FK
);

-- [좌석 로그 테이블 ] 생성
create table seat_log(
	seat_log_id int UNSIGNED NOT NULL AUTO_INCREMENT,
    member_no int UNSIGNED NOT NULL,
    now_time DATETIME NOT NULL,
    seat_no int UNSIGNED,
    state int not null,
	primary key (seat_log_id),
	foreign key (member_no) references member (member_no) ON DELETE CASCADE
);

-- 공지사항 테이블 생성
CREATE TABLE notice (
	notice_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	member_no INT UNSIGNED NOT NULL DEFAULT 1,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    view_count INT NOT NULL DEFAULT 0,
    category VARCHAR(50) NOT NULL,
    PRIMARY KEY (notice_id),
    FOREIGN KEY (member_no) REFERENCES member (member_no) ON DELETE CASCADE
);

-- 공지사항 첨부파일 테이블 생성
CREATE TABLE notice_attach (
	notice_attach_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    notice_id INT UNSIGNED NOT NULL,
    ori_name VARCHAR(255) NOT NULL,
    re_name VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    PRIMARY KEY (notice_attach_id),
    FOREIGN KEY (notice_id) REFERENCES notice (notice_id) ON DELETE CASCADE
);
    
-- 입실/퇴실 상태 테이블 생성
CREATE TABLE use_status (
	use_status_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    member_no INT UNSIGNED NULL,
    status INT NOT NULL DEFAULT 0,
    PRIMARY KEY (use_status_id),
    FOREIGN KEY (member_no) REFERENCES member (member_no) ON DELETE CASCADE
);

-- 입실/퇴실 로그 테이블 생성
CREATE TABLE use_log (
	use_log_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    member_no INT UNSIGNED NOT NULL,
    status INT NOT NULL,
    now_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (use_log_id),
    FOREIGN KEY (member_no) REFERENCES member (member_no) ON DELETE CASCADE
);