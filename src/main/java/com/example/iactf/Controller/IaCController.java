package com.example.iactf.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("api/v1/test")
@RestController
public class IaCController {

    @GetMapping
    public String helloWorld() {
        return "Hello World";
    }
}
