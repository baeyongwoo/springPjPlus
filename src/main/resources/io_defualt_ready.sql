-- 기존 테이블 삭제 (제약 조건과 시퀀스 포함)
DROP TABLE reply CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE tboard CASCADE CONSTRAINTS;
DROP TABLE tfile CASCADE CONSTRAINTS;
DROP TABLE bdfile CASCADE CONSTRAINTS;
DROP TABLE cate CASCADE CONSTRAINTS;
DROP TABLE dept CASCADE CONSTRAINTS;
DROP TABLE userinfo CASCADE CONSTRAINTS;
DROP TABLE auth CASCADE CONSTRAINTS;

-- 시퀀스 삭제
DROP SEQUENCE tboard_seq;
DROP SEQUENCE board_seq;
DROP SEQUENCE reply_seq;

-- 테이블 생성
CREATE TABLE dept (
    did     VARCHAR2(30) NOT NULL,
    dname   VARCHAR2(20) NOT NULL,
    CONSTRAINT dept_pk PRIMARY KEY (did)
);

CREATE TABLE cate (
    caid       VARCHAR2(20) NOT NULL,
    category   VARCHAR2(30) NOT NULL, 
    CONSTRAINT cate_pk PRIMARY KEY (caid)
);

CREATE TABLE userinfo (
    uemail   VARCHAR2(50) NOT NULL,
    upwd     VARCHAR2(30) NOT NULL,
    uname    VARCHAR2(20) DEFAULT 'Unknown', -- 기본값 추가
    did      VARCHAR2(30) NOT NULL,
    CONSTRAINT userinfo_pk PRIMARY KEY (uemail),
    CONSTRAINT userinfo_dept_fk FOREIGN KEY (did) REFERENCES dept(did)
);

CREATE TABLE auth (
    uemail    VARCHAR2(50) NOT NULL,
    authority VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_auth_usersinfo FOREIGN KEY (uemail) REFERENCES userinfo(uemail)
);

CREATE TABLE board (
    bno        NUMBER NOT NULL,
    title      VARCHAR2(100) NOT NULL,
    bcontent   VARCHAR2(2000) NOT NULL,
    uemail     VARCHAR2(50) NOT NULL,
    regdate    TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 기본값 추가
    caid       VARCHAR2(20) NOT NULL,
    CONSTRAINT board_pk PRIMARY KEY (bno),
    CONSTRAINT board_userinfo_fk FOREIGN KEY (uemail) REFERENCES userinfo(uemail),
    CONSTRAINT board_cate_fk FOREIGN KEY (caid) REFERENCES cate(caid)
);

CREATE TABLE tboard (
    tno          NUMBER NOT NULL,
    tmptitle     VARCHAR2(100) NOT NULL,
    tmpcontent   VARCHAR2(2000) NOT NULL,
    tmpregdate   TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 기본값 추가
    uemail       VARCHAR2(50) NOT NULL,
    caid         VARCHAR2(20) NOT NULL,
    code         VARCHAR2(10) DEFAULT 'ready', -- 기본값 추가 및 데이터 타입 변경
    CONSTRAINT tboard_pk PRIMARY KEY (tno),
    CONSTRAINT tboard_userinfo_fk FOREIGN KEY (uemail) REFERENCES userinfo(uemail),
    CONSTRAINT tboard_cate_fk FOREIGN KEY (caid) REFERENCES cate(caid)
);

CREATE TABLE reply (
    rno     NUMBER NOT NULL,
    rname   VARCHAR2(20) DEFAULT 'Anonymous', -- 기본값 추가
    rpwd    VARCHAR2(30) NOT NULL,
    rcon    VARCHAR2(1000) NOT NULL,
    bno     NUMBER NOT NULL,
    CONSTRAINT reply_pk PRIMARY KEY (rno),
    CONSTRAINT reply_board_fk FOREIGN KEY (bno) REFERENCES board(bno)
);

CREATE TABLE tfile (
    tuuid      VARCHAR2(100 BYTE) PRIMARY KEY, 
    tno        NUMBER NOT NULL,
    CONSTRAINT tfile_tboard_fk FOREIGN KEY (tno) REFERENCES tboard(tno),
    tUPLOADPATH VARCHAR2(200 BYTE) NOT NULL, 
    tFILENAME  VARCHAR2(200 BYTE) NOT NULL, 
    tFILETYPE  CHAR(1 BYTE) DEFAULT 'I' -- 기본값 추가
);

CREATE TABLE bdfile (
    buuid      VARCHAR2(100 BYTE) PRIMARY KEY, 
    bno        NUMBER NOT NULL,
    CONSTRAINT bdfile_board_fk FOREIGN KEY (bno) REFERENCES board(bno),
    bUPLOADPATH VARCHAR2(200 BYTE) NOT NULL, 
    bFILENAME  VARCHAR2(200 BYTE) NOT NULL, 
    bFILETYPE  CHAR(1 BYTE) DEFAULT 'I' -- 기본값 추가
);

-- 시퀀스 생성
CREATE SEQUENCE tboard_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE reply_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 데이터 삽입
INSERT INTO dept (did, dname) VALUES ('D01', '부서1');
INSERT INTO dept (did, dname) VALUES ('D02', '부서2');
INSERT INTO dept (did, dname) VALUES ('D00', 'Information Oceans');

INSERT INTO cate (caid, category) VALUES ('C01', '기술');
INSERT INTO cate (caid, category) VALUES ('C02', '비즈니스');

INSERT INTO userinfo (uemail, upwd, uname, did) VALUES ('user1@ex.com', 'pw1', '홍길동', 'D01');
INSERT INTO userinfo (uemail, upwd, uname, did) VALUES ('user2@ex.com', 'pw2', '김철수', 'D02');
-- 추가한 사용자
INSERT INTO userinfo (uemail, upwd, uname, did) VALUES ('io@io.io', 'password', '관리자', 'D00');

INSERT INTO auth (uemail, authority) VALUES ('user1@ex.com', 'Member');
INSERT INTO auth (uemail, authority) VALUES ('user2@ex.com', 'Admin');
INSERT INTO auth (uemail, authority) VALUES ('io@io.io', 'Admin');

INSERT INTO board (bno, title, bcontent, uemail, regdate, caid) VALUES (board_seq.NEXTVAL, '첫 번째 제목', '내용1', 'user1@ex.com', current_timestamp, 'C01');
INSERT INTO board (bno, title, bcontent, uemail, regdate, caid) VALUES (board_seq.NEXTVAL, '두 번째 제목', '내용2', 'user2@ex.com', current_timestamp, 'C02');

INSERT INTO tboard (tno, tmptitle, tmpcontent, tmpregdate, uemail, caid, code) VALUES (tboard_seq.NEXTVAL, '임시 제목 1', '임시 내용 1', current_timestamp, 'user1@ex.com', 'C01', 'ready');
INSERT INTO tboard (tno, tmptitle, tmpcontent, tmpregdate, uemail, caid, code) VALUES (tboard_seq.NEXTVAL, '임시 제목 2', '임시 내용 2', current_timestamp, 'user2@ex.com', 'C02', 'ready');

INSERT INTO reply (rno, rname, rpwd, rcon, bno) VALUES (reply_seq.NEXTVAL, '사용자1', '비밀번호1', '댓글 내용 1', 1);
INSERT INTO reply (rno, rname, rpwd, rcon, bno) VALUES (reply_seq.NEXTVAL, '사용자2', '비밀번호2', '댓글 내용 2', 1);

-- 데이터 확인 (주석 처리된 부분)
-- SELECT * FROM dept;
-- SELECT * FROM cate;
-- SELECT * FROM userinfo;
-- SELECT * FROM board;
-- SELECT * FROM tboard;
-- SELECT * FROM reply;
-- SELECT * FROM tfile;
-- SELECT * FROM bdfile;
