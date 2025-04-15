package com.giga.gw;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class GigachaApplication {

    public static void main(String[] args) {
        SpringApplication.run(GigachaApplication.class, args);
    }

}
