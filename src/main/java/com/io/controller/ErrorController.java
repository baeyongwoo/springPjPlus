package com.io.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorController {

    @GetMapping("/accessError")
    public String accessError() {
        return "accessError"; 
    }
}
