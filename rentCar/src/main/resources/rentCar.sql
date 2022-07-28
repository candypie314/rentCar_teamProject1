---- member
--DROP TABLE "TABLE";
--
---- 회원
--DROP TABLE "member";
--
---- 렌트카
--DROP TABLE "rent_car";
--
---- 예약정보
--DROP TABLE "reserve_info";
--
---- 게시판
--DROP TABLE "board";
--
---- 댓글
--DROP TABLE "comment";
--
---- 문화축제
--DROP TABLE "festival";
--
---- 모델가격
--DROP TABLE "model_price";
--
---- 자동차
--DROP TABLE "car";
--
--drop table "car" cascade CONSTRAINTS;
--drop table "board" cascade CONSTRAINTS;
--drop table "rent_car" cascade CONSTRAINTS;
--drop table "member" cascade CONSTRAINTS;
--drop table member;
-- 회원
CREATE TABLE "member" (
   "member_id"    VARCHAR2(20) NOT NULL, -- 회원id
   "member_pw"    VARCHAR2(20) NOT NULL, -- 회원pw
   "member_class" CHAR(1)      NULL,     -- 회원분류
   "member_name"  VARCHAR2(20) NULL,     -- 회원이름
   "member_birth" VARCHAR2(20) NULL,     -- 생년월일
   "member_phone" VARCHAR2(20) NULL,     -- 전화번호
   "member_email" VARCHAR2(50) NULL,     -- 이메일
   "member_date"  DATE         NULL      -- 가입날짜
);

-- 회원
ALTER TABLE "member"
   ADD
      CONSTRAINT "PK_member" -- 회원 기본키
      PRIMARY KEY (
         "member_id" -- 회원id
      );

-- 렌트카
CREATE TABLE "rent_car" (
   "car_number"   VARCHAR2(20) NOT NULL, -- 차량번호
   "car_model"    VARCHAR2(20) NULL,     -- 차량모델
   "car_color"    VARCHAR2(20) NULL,     -- 차량색상
   "car_distance" INTEGER      NULL      -- 주행거리
);

-- 렌트카
ALTER TABLE "rent_car"
   ADD
      CONSTRAINT "PK_rent_car" -- 렌트카 기본키
      PRIMARY KEY (
         "car_number" -- 차량번호
      );

-- 예약정보
CREATE TABLE "reserve_info" (
   "reserve_num"   VARCHAR2(20) NOT NULL, -- 예약번호
   "member_id"     VARCHAR2(20) NOT NULL, -- 회원id
   "car_model"     VARCHAR2(20) NULL,     -- 차량모델
   "car_number"    VARCHAR2(20) NOT NULL, -- 차량번호
   "reserve_date"  DATE         NULL,     -- 예약날짜
   "reserve_end"   DATE         NULL,     -- 예약종료날짜
   "reserve_price" VARCHAR2(20) NULL,     -- 렌트가격
   "reserve_area"  VARCHAR2(20) NULL      -- 렌트지역
);

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "PK_reserve_info" -- 예약정보 기본키
      PRIMARY KEY (
         "reserve_num" -- 예약번호
      );

-- 게시판
CREATE TABLE "board" (
   "board_num"     INTEGER       NOT NULL, -- 게시글번호
   "member_id"     VARCHAR2(20)  NOT NULL, -- 회원id(작성자)
   "board_origin"  INTEGER       NULL,     -- 원글번호
   "board_title"   VARCHAR2(20)  NULL,     -- 제목
   "board_content" VARCHAR2(200) NULL,     -- 내용
   "board_time"    DATE          NULL,     -- 작성시간
   "board_modify"  DATE          NULL      -- 최종수정시간
);

-- 게시판
ALTER TABLE "board"
   ADD
      CONSTRAINT "PK_board" -- 게시판 기본키
      PRIMARY KEY (
         "board_num", -- 게시글번호
         "member_id"  -- 회원id(작성자)
      );

-- 댓글
CREATE TABLE "comment" (
   "comment_num"     INTEGER       NOT NULL, -- 댓글번호
   "comment_origin"  INTEGER       NULL,     -- 원댓글번호
   "board_num"       INTEGER       NULL,     -- 게시글번호
   "comment_content" VARCHAR2(100) NULL,     -- 내용
   "member_id"       VARCHAR2(20)  NULL,     -- 회원id(작성자)
   "comment_date"    DATE          NULL      -- 작성시간
);

-- 댓글
ALTER TABLE "comment"
   ADD
      CONSTRAINT "PK_comment" -- 댓글 기본키
      PRIMARY KEY (
         "comment_num" -- 댓글번호
      );

-- 문화축제
CREATE TABLE "festival" (
   "festival_name"      VARCHAR2(20) NULL, -- 축제명
   "festival_area"      VARCHAR2(20) NULL, -- 개최장소
   "festival_date"      DATE         NULL, -- 축제시작날짜
   "festival_end"       DATE         NULL, -- 축제종료날짜
   "festival_institute" VARCHAR2(20) NULL, -- 주최기관
   "festival_phone"     VARCHAR2(20) NULL, -- 전화번호
   "festival_hompage"   VARCHAR2(20) NULL, -- 홈페이지주소
   "festival_address"   VARCHAR2(20) NULL, -- 도로명주소
   "latitude"           number(3,4)  NULL, -- 위도
   "longitude"          number(3,4)  NULL  -- 경도
);

-- 자동차
CREATE TABLE "car" (
   "car_model" VARCHAR2(20) NOT NULL, -- 차량모델
   "car_size"  VARCHAR2(20) NULL,     -- 차량크기
   "car_type"  VARCHAR2(20) NULL,     -- 차량종류
   "car_made"  VARCHAR2(20) NULL,     -- 제조사
   "car_price" VARCHAR2(20) NULL      -- 가격
);

-- 자동차
ALTER TABLE "car"
   ADD
      CONSTRAINT "PK_car" -- 자동차 기본키
      PRIMARY KEY (
         "car_model" -- 차량모델
      );

-- 렌트카
ALTER TABLE "rent_car"
   ADD
      CONSTRAINT "FK_car_TO_rent_car" -- 자동차 -> 렌트카
      FOREIGN KEY (
         "car_model" -- 차량모델
      )
      REFERENCES "car" ( -- 자동차
         "car_model" -- 차량모델
      );

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "FK_member_TO_reserve_info" -- 회원 -> 예약정보
      FOREIGN KEY (
         "member_id" -- 회원id
      )
      REFERENCES "member" ( -- 회원
         "member_id" -- 회원id
      );

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "FK_rent_car_TO_reserve_info" -- 렌트카 -> 예약정보
      FOREIGN KEY (
         "car_number" -- 차량번호
      )
      REFERENCES "rent_car" ( -- 렌트카
         "car_number" -- 차량번호
      );

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "FK_car_TO_reserve_info" -- 자동차 -> 예약정보
      FOREIGN KEY (
         "car_model" -- 차량모델
      )
      REFERENCES "car" ( -- 자동차
         "car_model" -- 차량모델
      );

-- 게시판
ALTER TABLE "board"
   ADD
      CONSTRAINT "FK_member_TO_board" -- 회원 -> 게시판
      FOREIGN KEY (
         "member_id" -- 회원id(작성자)
      )
      REFERENCES "member" ( -- 회원
         "member_id" -- 회원id
      );

-- 댓글
ALTER TABLE "comment"
   ADD
      CONSTRAINT "FK_board_TO_comment" -- 게시판 -> 댓글
      FOREIGN KEY (
         "board_num", -- 게시글번호
         "member_id"  -- 회원id(작성자)
      )
      REFERENCES "board" ( -- 게시판
         "board_num", -- 게시글번호
         "member_id"  -- 회원id(작성자)
      );

-- 댓글
ALTER TABLE "comment"
   ADD
      CONSTRAINT "FK_member_TO_comment" -- 회원 -> 댓글
      FOREIGN KEY (
         "member_id" -- 회원id(작성자)
      )
      REFERENCES "member" ( -- 회원
         "member_id" -- 회원id
      );
	  
-- index 자동차 목록에 추가
insert into "car" values ('티볼리','소형','가솔린','쌍용',100000);
insert into "car" values ('소나타','중형','가솔린','현대',150000);
insert into "car" values ('셀토스','소형','가솔린','기아',100000);
insert into "car" values ('팰리세이드','대형','가솔린','현대',200000);
insert into "car" values ('쏘렌토','SUV','디젤','기아',150000);
insert into "car" values ('니로EV','소형','전기','기아',100000);
insert into "car" values ('테슬라모델3','중형','전기','테슬라',250000);
insert into "car" values ('아반떼','중형','디젤','현대',100000);
select * from "car";

-- member (회원) 추가
select * from "member";
insert into "member" values ('aaa','aaaa','1','에이','980314','00011112222','aa@naver.com',sysdate);
insert into "member" values ('bbb','bbbb','1','비비','890704','00077774444','bb@naver.com',sysdate);
insert into "member" values ('admin','admin','2','admin','890704','00077774444','admin@naver.com',sysdate);
insert into "member" values ('admin2','admin2','2','admin2','890704','00077774444','admin@naver.com',sysdate);
insert into "member" values ('human','human','0','human','890704','00077774444','human@naver.com',sysdate);
insert into "member" values ('human02','human02','1','human02','890704','00077774444','admin@naver.com',sysdate);

-- rentCar에 넣을 시퀀스 추가. 차번호, 주행거리
create SEQUENCE seq_carNumber
minvalue 0
increment by 3
start with 1;

create SEQUENCE seq_carDistance
minvalue 0
increment by 3800
start with 80000;

-- rentCar 값 넣기
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '쏘렌토', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '니로EV', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '팰리세이드', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '아반떼', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '아반떼', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '아반떼', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '아반떼', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '테슬라모델3', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '테슬라모델3', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '테슬라모델3', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '테슬라모델3', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '테슬라모델3', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '셀토스', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '셀토스', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '셀토스', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '셀토스', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '소나타', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '소나타', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '소나타', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '소나타', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
insert into "rent_car" 
values (to_char(seq_carNumber.nextval), '티볼리', 'white', seq_carDistance.nextval);
