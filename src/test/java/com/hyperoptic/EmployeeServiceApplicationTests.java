package com.hyperoptic;

import com.hyperoptic.config.MockConfig;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@Import(MockConfig.class)
@ActiveProfiles("test")
class EmployeeServiceApplicationTests {

    @Test
    void contextLoads() {
    }
}
