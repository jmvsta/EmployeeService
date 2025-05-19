package com.hyperoptic;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

@SpringBootTest
@ActiveProfiles("test")
class EmployeeServiceApplicationTests {

    @MockitoBean
    SecurityFilterChain securityFilterChain;

    @Test
    void contextLoads() {
    }
}
