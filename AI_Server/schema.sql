CREATE SCHEMA `bank`;

create table `bank`.`member`
(
    id             int unsigned auto_increment
        primary key,
    email          varchar(100)                           not null,
    password       varchar(255)                           not null,
    name           varchar(30)                            not null,
    level          int unsigned default '1'               null,
    auth           varchar(20)  default '사원'              null,
    team           varchar(50)                            null,
    status         tinyint(1)   default 1                 null,
    counter_number int                                    null,
    join_date      date         default (curdate())       null,
    last_login     datetime                               null,
    created_at     timestamp    default CURRENT_TIMESTAMP null,
    constraint email
        unique (email)
);

create table `bank`.`user`
(
    id                    int unsigned auto_increment
        primary key,
    user_type             varchar(25)             null,
    name                  varchar(50)             not null,
    email                 varchar(50)             null,
    resident_number       varchar(100)            not null,
    identification_number varchar(100)            null,
    phone                 varchar(20)             null,
    password              varchar(100)            null,
    gender                enum ('MALE', 'FEMALE') null,
    age                   varchar(20)             null,
    grade                 varchar(20)             null,
    is_terms_agreed       tinyint(1) default 0    not null comment '필수 약관 전체 동의 여부',
    constraint email
        unique (email),
    constraint identification_number
        unique (identification_number),
    constraint resident_number
        unique (resident_number)
);



create table bank.task
(
    task_id               bigint auto_increment       primary key,
    user_id               int unsigned                          not null,
    ticket_number         varchar(20)                           not null,
    task_type             varchar(50)                           not null,
    task_detail_type      varchar(50)                           not null,
    assigned_level        varchar(20)                           null,
    expected_waiting_time int                                   null,
    status                varchar(20) default 'WAITING'         null,
    member_id             int unsigned                          null,
    ranking               int unsigned                          null,
    created_at            datetime    default CURRENT_TIMESTAMP null,
    updated_at            datetime    default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    is_ai                 BOOLEAN     DEFAULT FALSE             NULL,
    foreign key (user_id) references user (id)
        on update cascade on delete cascade
);



create table `bank`.`account`
(
    account_id          bigint auto_increment
        primary key,
    user_id             int unsigned                          not null,
    product_id          int unsigned                          null,
    account_number      varchar(40)                           not null,
    account_type        varchar(20)                           not null,
    balance             bigint      default 0                 not null,
    account_password    varchar(255)                          not null,
    status              varchar(20) default 'ACTIVE'          not null,
    password_fail_count int         default 0                 null,
    account_alias       varchar(20)                           null,
    interest_rate       decimal(5, 2)                         null,
    created_at          datetime    default CURRENT_TIMESTAMP null,
    last_transaction_at datetime    default CURRENT_TIMESTAMP null,
    maturity_date       datetime                              null,
    constraint uk_account_number
        unique (account_number),
    constraint fk_account_product
        foreign key (product_id) references financial_product (product_id)
            on update cascade on delete set null,
    constraint fk_account_user
        foreign key (user_id) references user (id)
            on update cascade
);


-- 게시판
create table `bank`.`board`
(
    board_id   int unsigned not null auto_increment primary key,
    user_id  int unsigned not null, -- 작성자 (최고관리자)
    board_type VARCHAR(20) not null,  -- notice / event 두개로 한정
    title      varchar(200) not null,
    content    text         not null,
    view_count int default 0 not null,         -- 조회수
    created_at datetime default CURRENT_TIMESTAMP not null,
    updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null,
    constraint foreign key (user_id) references user (id) on delete cascade
);

-- 금융 상품 관리 (Product)
create table `bank`.`financial_product`
(
    product_id          int unsigned auto_increment primary key,
    product_category    enum('CHECKING','DEPOSIT', 'SAVINGS', 'LOAN') not null,
    product_name        varchar(100)                                             not null,
    base_interest_rate  decimal(5, 2)                                            not null,
    max_interest_rate   decimal(5, 2)                                            null,
    min_duration_months int                                                      null,
    max_duration_months int                                                      null,
    min_amount          bigint                                                   null,
    max_amount          bigint                                                   null,
    description         text                                                     null,
    is_active           tinyint(1) default 1                                     null,
    target_type         enum ('INDIVIDUAL', 'CORPORATE', 'ALL')                 null,
    created_at          datetime   default CURRENT_TIMESTAMP                    null,
    updated_at          datetime   default CURRENT_TIMESTAMP                    null on update CURRENT_TIMESTAMP,
    min_age             int                                                      null,
    max_age             int                                                      null
    );


-- 카드
CREATE TABLE `bank`.`card`
(
    card_id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT UNSIGNED                         NOT NULL,
    account_id     BIGINT                               NULL,     -- account 테이블과 JOIN 할 핵심 연결고리!
    -- UI 노출 및 최소 결제 정보
    card_name      VARCHAR(50)                          NULL,     -- 카드 상품명
    card_number    VARCHAR(20)                          NOT NULL UNIQUE,
    card_type      VARCHAR(20)                          NOT NULL, -- 'CHECK' (체크), 'CREDIT' (신용)
    cvc            VARCHAR(3)                           NOT NULL,
    -- 상태 및 유효기간
    status         VARCHAR(20) DEFAULT 'ACTIVE'         NOT NULL,
    valid_thru     VARCHAR(5)                           NOT NULL, -- 'MM/YY' 형식
    issued_at      DATETIME    DEFAULT CURRENT_TIMESTAMP,
    credit_limit   BIGINT                                null, -- 신용한도
    used_amount    BIGINT                                null, -- 사용금액
    payment_day    INT                                   null, -- 납부일
    card_color     VARCHAR(20)                           NULL,
    is_activated   BOOLEAN     DEFAULT FALSE             NULL,
    -- 외래키(Foreign Key) 제약 조건
    CONSTRAINT fk_card_user FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_card_account FOREIGN KEY (account_id) REFERENCES account (account_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 거래 내역 (Transaction)

create table `bank`.`transaction_history`
(
    transaction_id   bigint auto_increment primary key,
    account_id       bigint                             not null,
    user_id          int unsigned                       null,     -- 처리를 도와준 행원 (ATM/모바일 뱅킹이면 null)
    task_id          bigint                             null,     -- 어떤 접수건(티켓)으로 인해 발생한 거래인지 추적
    transaction_type varchar(50)                        not null, -- 'DEPOSIT'(입금), 'WITHDRAWAL'(출금), 'TRANSFER'(이체) 등
    amount           bigint                             not null, -- 거래 금액 (한국 돈은 소수점이 없으므로 bigint가 적절합니다)
    balance_after    bigint                             not null, -- 거래 후 잔액
    description      varchar(100)                       null,     -- 적요 (예: "월급", "ATM출금")
    created_at       datetime default CURRENT_TIMESTAMP null,
    updated_at       datetime default CURRENT_TIMESTAMP null,
    constraint fk_tx_account
        foreign key (account_id) references account (account_id) on update cascade on delete cascade,
    constraint foreign key (user_id) references user (id) on update cascade
);


-- 상품 구독 테이블
create table `bank`.`product_subscription`
(
    subscription_id       int unsigned auto_increment
        primary key,
    user_id               int unsigned                          not null,
    product_id            int unsigned                          not null,
    task_id               bigint                                null,
    amount                bigint                                null,
    duration_months       int                                   null,
    applied_interest_rate decimal(5, 2)                         null,
    status                varchar(20) default 'ACTIVE'          null,
    payment_day           int                                   null,
    created_at            datetime    default CURRENT_TIMESTAMP null,
    constraint fk_sub_product
        foreign key (product_id) references financial_product (product_id),
    constraint fk_sub_user
        foreign key (user_id) references user (id)
);






-- 상담및 업무 처리

create table `bank`.`task_processing_log`
(
    log_id          bigint auto_increment primary key,
    task_id         bigint                               not null,
    member_id       int unsigned                         not null,
    action_type     varchar(50)                          not null, -- 'START_PROCESSING', 'ADD_NOTE', 'COMPLETE', 'TRANSFER'
    processing_note text                                 null,     -- 행원이 작성한 상담 내용 및 메모
    created_at      datetime   default CURRENT_TIMESTAMP not null,
    constraint fk_log_task foreign key (task_id) references task (task_id),
    constraint fk_log_member foreign key (member_id) references member (id)
);



-- 이메일 인증 테이블
create table bank.email_tokens
(
    email       varchar(50)          not null,
    code        varchar(12)          not null,
    is_verified tinyint(1) default 0 null,
    is_used     tinyint(1) default 0 null,
    created_at  datetime             null,
    expires_at  datetime             null,
    primary key (email, code)
);



-- 간편 비밀번호(PIN) 테이블
create table `bank`.`user_pin` (
                                   pin_id         bigint auto_increment primary key,
                                   user_id        int unsigned not null unique,
                                   pin_hash       varchar(255) not null,
                                   fail_count     int default 0 not null,
                                   locked_until   datetime null, -- 일정 시간 동안 잠금 기능 추가
                                   updated_at     datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
                                   constraint fk_pin_user foreign key (user_id) references user (id) on delete cascade
);


-- 대출

CREATE TABLE `bank`.`loan`
(
    loan_id            int auto_increment primary key,
    user_id            int unsigned                         not null,
    product_id         int unsigned                         not null, -- financial_product 참조
    linked_account_id  bigint                               not null, -- 이자 자동이체 및 대출금 입금 계좌
    principal_amount   bigint                               not null, -- 대출 원금
    outstanding_amount bigint                               not null, -- 남은 상환액 (잔액)
    interest_rate      decimal(5, 2)                        not null, -- 적용 이율
    payment_day        tinyint                              not null, -- 매월 이자 납입일 (1~31)
    info    varchar(255)                         null,     -- 담보 정보 (주담대, 전세대출용)
    status             varchar(20) default 'ACTIVE'         not null, -- 'ACTIVE', 'PAID_OFF', 'OVERDUE'
    overdue_date       date                                 null,     -- 연체 시작일 (연체관리용)
    overdue_amount     bigint      default 0                not null, -- 누적 연체 금액 (연체관리용)

    maturity_date      date                                 not null, -- 만기일
    created_at         datetime    default CURRENT_TIMESTAMP,
    updated_at         datetime    default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

    constraint fk_loan_user foreign key (user_id) references user (id),
    constraint fk_loan_product foreign key (product_id) references financial_product(product_id),
    constraint fk_loan_account foreign key (linked_account_id) references account (account_id)
);


-- 휴대 전화 인증 테이블
create table bank.sms_auth
(
    phone_number varchar(20)                        not null
        primary key,
    auth_code    varchar(6)                         not null,
    is_verified  boolean  default false             not null,
    created_at   datetime default CURRENT_TIMESTAMP not null,
    expires_at   datetime                           not null
);


-- 기업 부도/리스크 관리 테이블
CREATE TABLE `bank`.`corporate_management` (
                                               corporate_manage_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                                               user_id       INT UNSIGNED NOT NULL,       -- 기업 회원 ID
                                               loan_id       INT NOT NULL,                -- ★ 부도의 원인이 된 대출 ID (필수)

                                               risk_grade    VARCHAR(20) NOT NULL,        -- UI: 리스크 등급 (예: 고위험(E))
                                               default_date  DATE NOT NULL,               -- UI: 부도 발생일 (2026-04-25)
                                               reason        VARCHAR(100) NOT NULL,       -- UI: 부도 사유 (select 박스)
                                               description   TEXT,                        -- UI: 상세 경위 (textarea)

                                               created_at    DATETIME DEFAULT CURRENT_TIMESTAMP,

                                               CONSTRAINT fk_corp_user FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE,
                                               CONSTRAINT fk_corp_loan FOREIGN KEY (loan_id) REFERENCES loan (loan_id) ON DELETE CASCADE
);

-- 1. 대출 상환 스케줄 테이블 (loan_schedule)

CREATE TABLE bank.loan_schedule (
                                    schedule_id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    loan_id INT NOT NULL,                          -- BIGINT UNSIGNED에서 INT로 수정
                                    due_date DATE NOT NULL,                        -- 상환 예정일
                                    repay_amount DECIMAL(15, 2) NOT NULL,          -- 이번 회차 상환액 (원금+이자)
                                    status VARCHAR(20) DEFAULT 'SCHEDULED',        -- SCHEDULED(예정), PAID(납부완료), OVERDUE(연체)
                                    paid_at DATETIME,                              -- 실제 납부 일시
                                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                    CONSTRAINT fk_loan_schedule_loan FOREIGN KEY (loan_id) REFERENCES loan(loan_id) ON DELETE CASCADE
);

-- 2. 적금 납입 스케줄 테이블 (savings_schedule)
CREATE TABLE bank.savings_schedule (
                                       schedule_id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       account_id BIGINT NOT NULL,        -- 적금 계좌 마스터 테이블 FK
                                       due_date DATE NOT NULL,            -- 납입 예정일
                                       installment_amount DECIMAL(15, 2) NOT NULL, -- 월 약정 납입액
                                       status VARCHAR(20) DEFAULT 'PENDING', -- PENDING(대기중), COMPLETED(납입완료), MISSED(미납)
                                       paid_at DATETIME,                  -- 실제 납입 일시
                                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                       FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE CASCADE
);
-- 적금 계좌(확장)
CREATE TABLE bank.savings_account (
                                      account_id BIGINT PRIMARY KEY,       -- account 테이블의 PK와 동일 (1:1 매핑)
                                      linked_account_id BIGINT NOT NULL,   -- 매달 돈이 빠져나갈 입출금 계좌 ID
                                      installment_amount BIGINT NOT NULL,  -- 매월 약정 납입액
                                      term_months INT NOT NULL,            -- 가입 기간 (개월 수)
                                      payment_day INT NOT NULL,            -- 매월 자동이체 약정일 (예: 25일)
                                      maturity_date DATE NOT NULL,         -- 만기 예정일
                                      CONSTRAINT fk_savings_to_base_account FOREIGN KEY (account_id) REFERENCES account (account_id) ON DELETE CASCADE,
                                      CONSTRAINT fk_savings_to_linked_account FOREIGN KEY (linked_account_id) REFERENCES account (account_id)
);

-- 정기 예금
create table `bank`.`deposit_account`
(
    account_id         bigint                               not null primary key,
    linked_account_id  bigint                               not null, -- 만기 시 원리금이 입금될 계좌
    maturity_treatment enum ('AUTO_TERMINATE', 'AUTO_RENEW') not null default 'AUTO_TERMINATE', -- 만기처리방식 만기 자동해지, 자동 재예치
    constraint foreign key (account_id) references account (account_id)
        on delete cascade,
    constraint foreign key (linked_account_id) references account (account_id)
)