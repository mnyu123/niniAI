plugins {
	kotlin("jvm") version "1.9.25"
	kotlin("plugin.spring") version "1.9.25"
	id("org.springframework.boot") version "3.4.3"
	id("io.spring.dependency-management") version "1.1.7"
	kotlin("plugin.jpa") version "1.9.25"
}

group = "com.niniAI.backEnd"
version = "0.0.1-SNAPSHOT"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(17)
	}
}

configurations {
	compileOnly {
		extendsFrom(configurations.annotationProcessor.get())
	}
}

repositories {
	mavenCentral()
}

dependencies {
	// 필수: 웹 애플리케이션 및 REST API 지원
	implementation("org.springframework.boot:spring-boot-starter-web")
	// 필수: JPA를 통한 데이터베이스 연동
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	// JSON 처리를 위한 Kotlin 모듈
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	// Kotlin Reflection (Spring Boot 초기 설정 시 포함되지만 명시해두면 좋습니다)
	implementation("org.jetbrains.kotlin:kotlin-reflect")

	// 로컬 테스트를 위한 내장 데이터베이스 (H2)
	runtimeOnly("com.h2database:h2")

	// 테스트 관련 의존성
	testImplementation("org.springframework.boot:spring-boot-starter-test")
}

kotlin {
	compilerOptions {
		freeCompilerArgs.addAll("-Xjsr305=strict")
	}
}

allOpen {
	annotation("jakarta.persistence.Entity")
	annotation("jakarta.persistence.MappedSuperclass")
	annotation("jakarta.persistence.Embeddable")
}

tasks.withType<Test> {
	useJUnitPlatform()
}
