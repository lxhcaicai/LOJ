package com.github.loj.manager.oj;

import cn.hutool.core.util.IdUtil;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.utils.RedisUtils;
import com.wf.captcha.ArithmeticCaptcha;
import com.wf.captcha.base.Captcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/5/13 20:16
 */
@Component
public class CommonManager {

    @Autowired
    private RedisUtils redisUtils;

    public CaptchaVO getCaptcha() {
        ArithmeticCaptcha specCaptcha = new ArithmeticCaptcha(90, 30, 4);
        specCaptcha.setCharType(Captcha.TYPE_DEFAULT);
        // 2位数运算
        specCaptcha.setLen(2);
        String verCode = specCaptcha.text().toLowerCase();
        String key = IdUtil.simpleUUID();
        // 存入redis并设置过期时间为30分钟
        redisUtils.set(key, verCode, 1800);
        // 将key和base64返回给前端
        CaptchaVO captchaVO = new CaptchaVO()
                .setImg(specCaptcha.toBase64())
                .setCaptchaKey(key);
        return captchaVO;
    }

}
