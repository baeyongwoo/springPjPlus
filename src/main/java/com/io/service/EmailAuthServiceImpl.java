package com.io.service;

import org.springframework.stereotype.Service;
import java.util.Random;

@Service
public class EmailAuthServiceImpl implements EmailAuthService {

    private static final int CODE_LENGTH = 6;
    private Random random = new Random();

    @Override
    public String generateAuthCode() {
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < CODE_LENGTH; i++) {
            code.append(random.nextInt(10));
        }
        return code.toString();
    }
}
