package org.zerock.jex01.security.config;

import lombok.extern.log4j.Log4j2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.zerock.jex01.security.handler.CustomAccessDeniedHandler;
import org.zerock.jex01.security.handler.CustomAuthenticationEntryPoint;
import org.zerock.jex01.security.handler.CustomLoginSuccessHandler;
import org.zerock.jex01.security.service.CustomUserDetailsService;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@Log4j2
@MapperScan(basePackages = "org.zerock.jex01.security.mapper")
@ComponentScan(basePackages = "org.zerock.jex01.security.service")
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    private DataSource dataSource;

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();

    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

//        http.authorizeRequests()
//                .antMatchers("/sample/doAll").permitAll()
//                .antMatchers("/sample/doMember").access("hasRole('ROLE_MEMBER')")
//                .antMatchers("/sample/doAdmin").access("hasRole('ROLE_ADMIN')");

        http.formLogin().loginPage("/customLogin")
                .loginProcessingUrl("/login").successHandler(customLoginSuccessHandler());

        //http.logout().invalidateHttpSession(true); 이거 안줘도 로그아웃 동작함.

        http.csrf().disable(); // 로그아웃 페이지 따로 만들지 않아도 된다. 그냥 logout만 입력하면 되드라.

        http.rememberMe().tokenRepository(persistentTokenRepository()).key("khan").tokenValiditySeconds(60*60*24*30);

        http.exceptionHandling().accessDeniedHandler(customAccessDeniedHandler());

        http.exceptionHandling()
                .authenticationEntryPoint(customAuthenticationEntryPoint());
    }

    @Bean //스프링쓸때는 객체를 바로쓰지 않고 빈을 생성해서 주입하는 방식을 권장한다.
    public CustomAccessDeniedHandler customAccessDeniedHandler(){
        return new CustomAccessDeniedHandler();
    }

    @Bean
    public CustomAuthenticationEntryPoint customAuthenticationEntryPoint(){
        return new CustomAuthenticationEntryPoint();
    }

    @Bean
    public CustomLoginSuccessHandler customLoginSuccessHandler(){
        return new CustomLoginSuccessHandler();
    }

//    @Bean
//    public CustomUserDetailsService customUserDetailsService(){
//        return new CustomUserDetailsService();
//    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth.userDetailsService(customUserDetailsService);
//        auth.inMemoryAuthentication().withUser("member1").password("$2a$10$EwIxQ4n8fz3bHY49307wj.M/HsUMi50Pc3xY57VaFgQGVHnO5gUFm")
//                .roles("MEMBER");
//
//        auth.inMemoryAuthentication().withUser("admin1").password("$2a$10$EwIxQ4n8fz3bHY49307wj.M/HsUMi50Pc3xY57VaFgQGVHnO5gUFm")
//                .roles("MEMBER","ADMIN");
    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository(){
        JdbcTokenRepositoryImpl repository = new JdbcTokenRepositoryImpl();
        repository.setDataSource(dataSource);
        return repository;
    }


}
