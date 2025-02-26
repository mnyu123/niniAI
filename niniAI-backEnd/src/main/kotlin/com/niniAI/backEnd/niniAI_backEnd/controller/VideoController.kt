package com.niniAI.backEnd.niniAI_backEnd.controller

import com.niniAI.backEnd.niniAI_backEnd.dto.niniAIVideoDto
import com.niniAI.backEnd.niniAI_backEnd.service.YouTubeService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/")
class VideoController(
        private val youTubeService: YouTubeService
) {

    /**
     * GET /niniai_videos
     * 모든 동영상(페이지네이션 처리)을 반환
     * ?page=0&size=10 (기본값)
     */
    @GetMapping("/niniai_videos")
    fun getVideos(
            @RequestParam(required = false, defaultValue = "0") page: Int,
            @RequestParam(required = false, defaultValue = "10") size: Int,
            @RequestParam(required = false) channel: String?
    ): ResponseEntity<List<niniAIVideoDto>> {
        val videos: List<niniAIVideoDto> = if (channel.isNullOrEmpty()) {
            youTubeService.getAllVideos(page, size)
        } else {
            youTubeService.getVideosByChannel(channel, page, size)
        }
        return ResponseEntity.ok(videos)
    }

    /**
     * GET /video/{id}
     * 단일 동영상의 상세 정보를 반환
     */
    @GetMapping("/video/{id}")
    fun getVideoDetail(@PathVariable id: String): ResponseEntity<niniAIVideoDto> {
        val video = youTubeService.getVideoDetail(id)
        return if (video != null) ResponseEntity.ok(video)
        else ResponseEntity.notFound().build()
    }
}