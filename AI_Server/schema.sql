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
    task_id               bigint auto_increment primary key,
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

-- 금융 상품 관리 (Product)
create table `bank`.`financial_product`
(
    product_id          int unsigned auto_increment primary key,
    product_category    enum('CHECKING','DEPOSIT', 'SAVINGS', 'LOAN') not null,
    product_name        varchar(100)                                   not null,
    base_interest_rate  decimal(5, 2)                                  not null,
    max_interest_rate   decimal(5, 2)                                  null,
    min_duration_months int                                            null,
    max_duration_months int                                            null,
    min_amount          bigint                                         null,
    max_amount          bigint                                         null,
    description         text                                           null,
    is_active           tinyint(1) default 1                           null,
    target_type         enum ('INDIVIDUAL', 'CORPORATE', 'ALL')        null,
    created_at          datetime   default CURRENT_TIMESTAMP           null,
    updated_at          datetime   default CURRENT_TIMESTAMP           null on update CURRENT_TIMESTAMP
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
    user_id    int unsigned not null,
    board_type VARCHAR(20)  not null,
    title      varchar(200) not null,
    content    text         not null,
    view_count int default 0 not null,
    created_at datetime default CURRENT_TIMESTAMP not null,
    updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null,
    constraint foreign key (user_id) references user (id) on delete cascade
);

-- 카드
CREATE TABLE `bank`.`card`
(
    card_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT UNSIGNED                         NOT NULL,
    account_id   BIGINT                               NULL,
    card_name    VARCHAR(50)                          NULL,
    card_number  VARCHAR(20)                          NOT NULL UNIQUE,
    card_type    VARCHAR(20)                          NOT NULL,
    cvc          VARCHAR(3)                           NOT NULL,
    status       VARCHAR(20) DEFAULT 'ACTIVE'         NOT NULL,
    valid_thru   VARCHAR(5)                           NOT NULL,
    issued_at    DATETIME    DEFAULT CURRENT_TIMESTAMP,
    credit_limit BIGINT                               NULL,
    used_amount  BIGINT                               NULL,
    payment_day  INT                                  NULL,
    card_color   VARCHAR(20)                          NULL,
    is_activated BOOLEAN     DEFAULT FALSE            NULL,
    CONSTRAINT fk_card_user FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_card_account FOREIGN KEY (account_id) REFERENCES account (account_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 거래 내역
create table `bank`.`transaction_history`
(
    transaction_id   bigint auto_increment primary key,
    account_id       bigint                             not null,
    user_id          int unsigned                       null,
    task_id          bigint                             null,
    transaction_type varchar(50)                        not null,
    amount           bigint                             not null,
    balance_after    bigint                             not null,
    description      varchar(100)                       null,
    created_at       datetime default CURRENT_TIMESTAMP null,
    updated_at       datetime default CURRENT_TIMESTAMP null,
    constraint fk_tx_account
        foreign key (account_id) references account (account_id) on update cascade on delete cascade,
    constraint foreign key (user_id) references user (id) on update cascade
);

-- 상품 구독
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

-- 상담 및 업무 처리 로그
create table `bank`.`task_processing_log`
(
    log_id          bigint auto_increment primary key,
    task_id         bigint                               not null,
    member_id       int unsigned                         not null,
    action_type     varchar(50)                          not null,
    processing_note text                                 null,
    created_at      datetime   default CURRENT_TIMESTAMP not null,
    constraint fk_log_task foreign key (task_id) references task (task_id),
    constraint fk_log_member foreign key (member_id) references member (id)
);

-- 이메일 인증
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

-- 간편 비밀번호(PIN)
create table `bank`.`user_pin`
(
    pin_id       bigint auto_increment primary key,
    user_id      int unsigned not null unique,
    pin_hash     varchar(255) not null,
    fail_count   int default 0 not null,
    locked_until datetime     null,
    updated_at   datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_pin_user foreign key (user_id) references user (id) on delete cascade
);

-- 대출
CREATE TABLE `bank`.`loan`
(
    loan_id            int auto_increment primary key,
    user_id            int unsigned                         not null,
    product_id         int unsigned                         not null,
    linked_account_id  bigint                               not null,
    principal_amount   bigint                               not null,
    outstanding_amount bigint                               not null,
    interest_rate      decimal(5, 2)                        not null,
    payment_day        tinyint                              not null,
    info               varchar(255)                         null,
    status             varchar(20) default 'ACTIVE'         not null,
    overdue_date       date                                 null,
    overdue_amount     bigint      default 0                not null,
    maturity_date      date                                 not null,
    created_at         datetime    default CURRENT_TIMESTAMP,
    updated_at         datetime    default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_loan_user foreign key (user_id) references user (id),
    constraint fk_loan_product foreign key (product_id) references financial_product (product_id),
    constraint fk_loan_account foreign key (linked_account_id) references account (account_id)
);

-- 휴대전화 인증
create table bank.sms_auth
(
    phone_number varchar(20)                        not null primary key,
    auth_code    varchar(6)                         not null,
    is_verified  boolean  default false             not null,
    created_at   datetime default CURRENT_TIMESTAMP not null,
    expires_at   datetime                           not null
);

-- 기업 부도/리스크 관리
CREATE TABLE `bank`.`corporate_management`
(
    corporate_manage_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id             INT UNSIGNED  NOT NULL,
    loan_id             INT           NOT NULL,
    risk_grade          VARCHAR(20)   NOT NULL,
    default_date        DATE          NOT NULL,
    reason              VARCHAR(100)  NOT NULL,
    description         TEXT,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_corp_user FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE,
    CONSTRAINT fk_corp_loan FOREIGN KEY (loan_id) REFERENCES loan (loan_id) ON DELETE CASCADE
);

-- 대출 상환 스케줄
CREATE TABLE bank.loan_schedule
(
    schedule_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    loan_id        INT            NOT NULL,
    due_date       DATE           NOT NULL,
    repay_amount   DECIMAL(15, 2) NOT NULL,
    status         VARCHAR(20) DEFAULT 'SCHEDULED',
    paid_at        DATETIME,
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_loan_schedule_loan FOREIGN KEY (loan_id) REFERENCES loan (loan_id) ON DELETE CASCADE
);

-- 적금 납입 스케줄
CREATE TABLE bank.savings_schedule
(
    schedule_id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id         BIGINT         NOT NULL,
    due_date           DATE           NOT NULL,
    installment_amount DECIMAL(15, 2) NOT NULL,
    status             VARCHAR(20) DEFAULT 'PENDING',
    paid_at            DATETIME,
    created_at         DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account (account_id) ON DELETE CASCADE
);

-- 적금 계좌 확장
CREATE TABLE bank.savings_account
(
    account_id         BIGINT PRIMARY KEY,
    linked_account_id  BIGINT NOT NULL,
    installment_amount BIGINT NOT NULL,
    term_months        INT    NOT NULL,
    payment_day        INT    NOT NULL,
    maturity_date      DATE   NOT NULL,
    CONSTRAINT fk_savings_to_base_account FOREIGN KEY (account_id) REFERENCES account (account_id) ON DELETE CASCADE,
    CONSTRAINT fk_savings_to_linked_account FOREIGN KEY (linked_account_id) REFERENCES account (account_id)
);

-- 정기 예금 계좌 확장
create table `bank`.`deposit_account`
(
    account_id         bigint                                not null primary key,
    linked_account_id  bigint                                not null,
    maturity_treatment enum ('AUTO_TERMINATE', 'AUTO_RENEW') not null default 'AUTO_TERMINATE',
    constraint foreign key (account_id) references account (account_id) on delete cascade,
    constraint foreign key (linked_account_id) references account (account_id)
);

-- 금리 이력
create table `bank`.`product_interest_rate`
(
    rate_id    int unsigned auto_increment primary key,
    product_id int unsigned  not null,
    rate       decimal(5, 2) not null,
    changed_at datetime default CURRENT_TIMESTAMP,
    constraint fk_rate_product foreign key (product_id) references financial_product (product_id) on delete cascade
);
