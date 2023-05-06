package com.github.loj.utils;

/**
 * @author lxhcaicai
 * @date 2023/4/24 0:28
 */
public class Constants {
    /**
     * 账户相关常量
     */
    public enum Account{
        CODE_CHANGE_PASSWORD_FAIL("change-password-fail:"),
        CODE_CHANGE_PASSWORD_LOCK("change-password-lock:"),
        CODE_ACCOUNT_LOCK("account-lock:"),
        CODE_CHANGE_EMAIL_FAIL("change-email-fail:"),
        CODE_CHANGE_EMAIL_LOCK("change-email-lock:"),

        TRY_LOGIN_NUM("try-login-num:"),

        ACM_RANK_CACHE("acm_rank_cache"),
        OI_RANK_CACHE("oi_rank_cache"),

        GROUP_RANK_CACHE("group_rank_cache"),
        SUPER_ADMIN_UID_LIST_CACHE("super_admin_uid_list_case"),
        SUBMIT_NON_CONTEST_LOCK("submit_non_contest_lock:"),
        TEST_JUDGE_LOCK("test_judge_lock:"),
        SUBMIT_CONTEST_LOCK("submit_contest_lock:"),
        DISCUSSION_ADD_NUM_LOCK("discussion_add_num_lock:"),
        GROUP_ADD_NUM_LOCK("group_add_num_lock"),
        CONTEST_ADD_PRINT_LOCK("contest_add_print_lock:"),

        REMOTE_JUDGE_CF_ACCOUNT_NUM("remote_judge_cf_account:");

        private final String code;

        Account(String code) {
            this.code = code;
        }

        public String getCode() {
            return code;
        }
    }

    /**
     * 提交评测结果的状态码
     */
    public enum Judge{
        STATUS_NOT_SUBMITTED(-10, "Not Submitted", null),
        STATUS_SUBMITTED_UNKNOWN_RESULT(-5, "Submitted Unknown Result", null),
        STATUS_CANCELLED(-4, "Cancelled", "ca"),
        STATUS_PRESENTATION_ERROR(-3, "Presentation Error", "pe"),
        STATUS_COMPILE_ERROR(-2, "Compile Error", "ce"),
        STATUS_WRONG_ANSWER(-1, "Wrong Answer", "wa"),
        STATUS_ACCEPTED(0, "Accepted", "ac"),
        STATUS_TIME_LIMIT_EXCEEDED(1, "Time Limit Exceeded", "tle"),
        STATUS_MEMORY_LIMIT_EXCEEDED(2, "Memory Limit Exceeded", "mle"),
        STATUS_RUNTIME_ERROR(3, "Runtime Error", "re"),
        STATUS_SYSTEM_ERROR(4, "System Error", "se"),
        STATUS_PENDING(5, "Pending", null),
        STATUS_COMPILING(6, "Compiling", null),
        STATUS_JUDGING(7, "Judging", null),
        STATUS_PARTIAL_ACCEPTED(8, "Partial Accepted", "pa"),
        STATUS_SUBMITTING(9, "Submitting", null),
        STATUS_SUBMITTED_FAILED(10, "Submitted Failed", null),
        STATUS_NULL(15, "No Status", null),
        JUDGE_SERVER_SUBMIT_PREFIX(-1002, "Judge SubmitId-ServerId:", null);

        private final Integer status;
        private final String name;
        private final String columnName;

        private Judge(Integer status, String name, String columnName) {
            this.status = status;
            this.name = name;
            this.columnName = columnName;
        }

        public Integer getStatus() {
            return status;
        }

        public String getName() {
            return name;
        }

        public String getColumnName() {
            return columnName;
        }
    }

    /**
     * 等待判题的redis队列
     */
    public enum Queue {
        CONTEST_JUDGE_WAITING("Contest_Waiting_Handle_Queue"),
        GENERAL_JUDGE_WAITING("General_Waiting_Handle_Queue"),
        TEST_JUDGE_WAITING("Test_Judge_Waiting_Handle_Queue"),
        CONTEST_REMOTE_JUDGE_WAITING_HANDLE("Contest_Remote_Waiting_Handle_Queue"),
        GENERAL_REMOTE_JUDGE_WAITING_HANDLE("General_Remote_Waiting_Handle_Queue");

        private final String name;

        private Queue(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }
    }
}
