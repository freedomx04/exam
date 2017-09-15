package com.hm.exam.common.utils;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;

@Configuration
public class CaptchaConfig {

	@Value("${kaptcha.session.key}")
	private String skey;

	@Value("${kaptcha.textproducer.font.color}")
	private String fcolor;

	@Value("${kaptcha.textproducer.font.size}")
	private String fsize;
	
	@Value("${kaptcha.textproducer.font.names}")
	private String fname;

	@Value("${kaptcha.noise.impl}")
	private String noise;
	
	@Value("${kaptcha.noise.color}")
	private String ncolor;

	@Value("${kaptcha.image.width}")
	private String width;

	@Value("${kaptcha.image.height}")
	private String height;

	@Value("${kaptcha.textproducer.char.length}")
	private String clength;

	@Value("${kaptcha.textproducer.char.space}")
	private String cspace;

	@Value("${kaptcha.background.clear.from}")
	private String from;

	@Value("${kaptcha.background.clear.to}")
	private String to;

	@Bean(name = "captchaProducer")
	public DefaultKaptcha getKaptchaBean() {
		DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
		Properties properties = new Properties();
		properties.setProperty("kaptcha.border", "no");// 无边框
		properties.setProperty("kaptcha.session.key", skey);// session key
		properties.setProperty("kaptcha.textproducer.font.color", fcolor);
		properties.setProperty("kaptcha.textproducer.font.size", fsize);
		properties.setProperty("kaptcha.textproducer.font.names", fname);
		properties.setProperty("kaptcha.noise.impl", noise);
		properties.setProperty("kaptcha.noise.color", ncolor);
		properties.setProperty("kaptcha.image.width", width);
		properties.setProperty("kaptcha.image.height", height);
		properties.setProperty("kaptcha.textproducer.char.length", clength);
		properties.setProperty("kaptcha.textproducer.char.space", cspace);
		properties.setProperty("kaptcha.background.clear.from", from); // 和登录框背景颜色一致
		properties.setProperty("kaptcha.background.clear.to", to);

		Config config = new Config(properties);
		defaultKaptcha.setConfig(config);
		return defaultKaptcha;
	}
}
