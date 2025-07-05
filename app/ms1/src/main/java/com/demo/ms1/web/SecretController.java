package com.demo.ms1.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class SecretController {

    @Value("${username:unknown}")
    private String username;

    @Value("${password:unknown}")
    private String password;

    @GetMapping("/secret")
    public Map<String, String> showSecret() {
        return Map.of(
                "user", username,
                "pass", password
        );
    }
}

