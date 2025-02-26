package com.niniAI.backEnd.niniAI_backEnd.config

import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

@Configuration
class WebConfig : WebMvcConfigurer {
    override fun addCorsMappings(registry: CorsRegistry) {
        registry.addMapping("/**")
                .allowedOrigins(
                        "http://localhost:3000",    // 개발용 프론트엔드
                        "http://127.0.0.1:3000",
                        "https://dokhub-love-doksaem.netlify.app",
                        "http://52.79.242.58",
                        "https://www.googleapis.com" // 필요 시
                )
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(false)
    }
}