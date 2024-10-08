package com.microrepo.service1;

import org.springframework.boot.SpringApplication;

public class TestService1Application {

    public static void main(String[] args) {
        SpringApplication.from(Service1Application::main)
                .with(TestcontainersConfiguration.class)
                .run(args);
    }
}
