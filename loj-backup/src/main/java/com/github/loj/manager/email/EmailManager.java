package com.github.loj.manager.email;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Validator;
import cn.hutool.core.text.UnicodeUtil;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.WebConfig;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;

/**
 * @author lxhcaicai
 * @date 2023/5/13 0:29
 */

@Component
@RefreshScope
@Slf4j(topic = "loj")
public class EmailManager {

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private TemplateEngine templateEngine;

    /**
     * 验证当前邮箱系统是否已经配置
     * @return
     */
    public boolean isOk() {
        WebConfig webConfig = nacosSwitchConfig.getWebConfig();
        return webConfig.getEmailUsername() != null
                && webConfig.getEmailPassword() != null
                && !webConfig.getEmailUsername().equals("your_email_username")
                && !webConfig.getEmailPassword().equals("your_email_password")
                && Validator.isEmail(webConfig.getEmailUsername());
    }

    /**
     * 需要重置密码的用户名
     *
     * @param username
     * @param code 随机生成20位数字与字母的组合
     * @param email 用户邮箱
     * 给指定的邮箱的用户发送重置密码链接的邮件。
     */
    @Async
    public void sendResetPassword(String username, String code, String email) {
        DateTime expireTime = DateUtil.offsetMinute(new Date(),10);
        JavaMailSenderImpl mailSender = getMailSender();
        MimeMessage mimeMessage = mailSender.createMimeMessage();

        try {
            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage,true);

            // 设置渲染到html页面对应的值
            Context context = new Context();
            WebConfig webConfig = nacosSwitchConfig.getWebConfig();
            context.setVariable(Constants.Email.OJ_NAME.name(), UnicodeUtil.toString(webConfig.getName()));
            context.setVariable(Constants.Email.OJ_SHORT_NAME.name(), UnicodeUtil.toString(webConfig.getShortName()));
            context.setVariable(Constants.Email.OJ_URL.name(), webConfig.getBaseUrl());
            context.setVariable(Constants.Email.EMAIL_BACKGROUND_IMG.name(), webConfig.getEmailBGImg());

            String resetUrl;
            if(webConfig.getBaseUrl().endsWith("/")) {
                resetUrl = webConfig.getBaseUrl() + "reset-password?username=" + username + "&code=" + code;
            } else {
                resetUrl = webConfig.getBaseUrl() + "/reset-password?username=" + username + "&code=" + code;
            }

            context.setVariable("RESET_URL", resetUrl);
            context.setVariable("EXPIRE_TIME", expireTime.toString());
            context.setVariable("USERNAME", username);

            // 利用模板引擎加载html文件进行渲染并生成对应的字符串
            String emailContent = templateEngine.process("emailTemplate_resetPassword", context);

            mimeMessageHelper.setSubject(UnicodeUtil.toString(webConfig.getShortName()) + "的重置密码邮件");

            mimeMessageHelper.setText(emailContent, true);
            // 收件人
            mimeMessageHelper.setTo(email);
            // 发送人
            mimeMessageHelper.setFrom(webConfig.getEmailUsername());
            mailSender.send(mimeMessage);

        } catch (MessagingException e) {
            log.error("用户重置密码的邮件任务发生异常------------>{}", e.getMessage());
        }
    }

    /**
     * 获取邮件系统配置
     * @return
     */
    private JavaMailSenderImpl getMailSender() {
        WebConfig webConfig = nacosSwitchConfig.getWebConfig();
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setHost(webConfig.getEmailHost());
        sender.setPort(webConfig.getEmailPort());
        sender.setDefaultEncoding("UTF-8");
        sender.setUsername(webConfig.getEmailUsername());
        sender.setPassword(webConfig.getEmailPassword());

        Properties properties = new Properties();
        properties.setProperty("mail.smtp.ssl.enable", webConfig.getEmailSsl().toString());
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", webConfig.getEmailSsl().toString());
        sender.setJavaMailProperties(properties);
        return sender;
    }

    @Async
    public void  sendRegisterCode(String email, String code) {
        DateTime expireTime = DateUtil.offsetMinute(new Date(), 10);
        JavaMailSenderImpl mailSender = getMailSender();
        MimeMessage mimeMessage = mailSender.createMimeMessage();

        try {

            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);
            // 设置渲染到html页面对应的值
            Context context = new Context();
            WebConfig webConfig = nacosSwitchConfig.getWebConfig();
            context.setVariable(Constants.Email.OJ_NAME.name(), UnicodeUtil.toString(webConfig.getName()));
            context.setVariable(Constants.Email.OJ_SHORT_NAME.name(), UnicodeUtil.toString(webConfig.getShortName()));
            context.setVariable(Constants.Email.OJ_URL.name(), webConfig.getBaseUrl());
            context.setVariable(Constants.Email.EMAIL_BACKGROUND_IMG.name(), webConfig.getEmailBGImg());
            context.setVariable("CODE", code);
            context.setVariable("EXPIRE_TIME", expireTime.toString());
            //利用模板引擎加载html文件进行渲染并生成对应的字符串
            String emailContent = templateEngine.process("emailTemplate_registerCode", context);

            // 设置邮件标题
            mimeMessageHelper.setSubject(UnicodeUtil.toString(webConfig.getShortName()) + "的注册邮件");
            mimeMessageHelper.setText(emailContent, true);
            // 收件人
            mimeMessageHelper.setTo(email);
            // 发送人
            mimeMessageHelper.setFrom(webConfig.getEmailUsername());

            mailSender.send(mimeMessage);

        } catch (MessagingException e) {
            log.error("用户注册的邮件任务发生异常------------>{}", e.getMessage());
        }
    }


}
