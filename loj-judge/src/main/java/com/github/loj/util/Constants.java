package com.github.loj.util;

/**
 * @author lxhcaicai
 * @date 2023/4/15 11:23
 */
public class Constants {
    public enum Judge {
        // 提交失败
        STATUS_NOT_SUBMITTED(-10, "Not Submitted"),
        STATUS_CANCELLED(-4, "Cancelled"),
        STATUS_PRESENTATION_ERROR(-3, "Presentation Error"),
        STATUS_COMPILE_ERROR(-2, "Compile Error"),
        STATUS_WRONG_ANSWER(-1, "Wrong Answer"),
        STATUS_ACCEPTED(0, "Accepted"),
        STATUS_TIME_LIMIT_EXCEEDED(1, "Time Limit Exceeded"),
        STATUS_MEMORY_LIMIT_EXCEEDED(2, "Memory Limit Exceeded"),
        STATUS_RUNTIME_ERROR(3, "Runtime Error"),
        STATUS_SYSTEM_ERROR(4, "System Error"),
        STATUS_COMPILING(6,"Compiling"),

        // 正在等待结果
        STATUS_JUDGING(7, "Judging"),
        STATUS_PARTIAL_ACCEPTED(8, "Partial Accepted"),
        STATUS_SUBMITTING(9, "Submitting"),
        STATUS_SUBMITTED_FAILED(10, "Submitted Failed"),
        STATUS_NULL(15, "No Status");


        private final Integer status;
        private final String name;

        private Judge(Integer status, String name) {
            this.status = status;
            this.name = name;
        }

        public Integer getStatus() {
            return status;
        }

        public String getName() {
            return name;
        }

        public static Judge getTypeByStatus(int status) {
            for(Judge judge: Judge.values()) {
                if(judge.getStatus() == status) {
                    return judge;
                }
            }
            return STATUS_NULL;
        }
    }


    public enum JudgeMode {
        TEST("test"),
        DEFAULT("default"),
        SPJ("spj"),
        INTERACTIVE("interactive");

        private final String mode;

        JudgeMode(String mode) {
            this.mode = mode;
        }

        public String getMode() {
            return mode;
        }

        public static JudgeMode getJudgeMode(String mode) {
            for(JudgeMode judgeMode: JudgeMode.values()) {
                if(judgeMode.getMode().equals(mode)) {
                    return judgeMode;
                }
            }
            return null;
        }
    }

    public enum JudgeDir {
        RUN_WORKPLACE_DIR("/judge/run"),
        TEST_CASE_DIR("/judge/test_case"),
        SPJ_WORKPLACE_DIR("/judge/spj"),
        INTERACTIVE_WORKPLACE_DIR("/judge/interactive"),
        TMPFS_DIR("/w");

        private final String content;

        JudgeDir(String content) {
            this.content = content;
        }

        public String getContent() {
            return content;
        }
    }

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
}
