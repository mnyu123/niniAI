package com.niniAI.backEnd.niniAI_backEnd

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cache.annotation.EnableCaching
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableCaching      // 캐시 활성화
@EnableScheduling   // 스케줄링 활성화 (주기적 업데이트)
class NiniAiBackEndApplication

fun main(args: Array<String>) {
	runApplication<NiniAiBackEndApplication>(*args)
}
