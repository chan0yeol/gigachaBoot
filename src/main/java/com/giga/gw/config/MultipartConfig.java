package com.giga.gw.config;

import jakarta.servlet.MultipartConfigElement;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

//@Configuration
public class MultipartConfig {
    @Bean
    public MultipartResolver multipartResolver(){
        return new StandardServletMultipartResolver();
    }

    @Bean
    public MultipartConfigElement multipartConfigElement(){
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setLocation( "file:D:/gigacha/uploads");
        factory.setMaxFileSize(DataSize.ofMegabytes(5L));
        factory.setMaxRequestSize(DataSize.ofMegabytes(5L));

        return factory.createMultipartConfig();
    }


}
