package com.io.mybatis;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.io.security.CustomUserDetailsService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/WEB-INF/spring/security-context.xml"})
public class MyBatisConfigTest {
    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Test
    public void testLoadUserByUsername() {
        String username = "test@example.com";
        try {
            UserDetails userDetails = customUserDetailsService.loadUserByUsername(username);
            assertNotNull(userDetails);
            assertEquals(username, userDetails.getUsername());
        } catch (UsernameNotFoundException e) {
            fail("User not found: " + username);
        }
    }
}


