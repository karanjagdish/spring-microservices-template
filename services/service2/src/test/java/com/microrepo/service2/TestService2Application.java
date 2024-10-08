package com.microrepo.service2;

import org.springframework.boot.SpringApplication;

public class TestService2Application {

    public static void main(String[] args) {
        SpringApplication.from(Service2Application::main)
                .with(TestcontainersConfiguration.class)
                .run(args);
    }
}
