package com.niniAI.backEnd.niniAI_backEnd.service

import com.fasterxml.jackson.annotation.JsonProperty
import com.niniAI.backEnd.niniAI_backEnd.dto.niniAIVideoDto
import com.niniAI.backEnd.niniAI_backEnd.entity.niniAIMetadata
import com.niniAI.backEnd.niniAI_backEnd.repository.niniAIMetadataRepository
import org.springframework.beans.factory.annotation.Value
import org.springframework.cache.annotation.Cacheable
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Service
class YouTubeService(
        private val videoMetadataRepository: niniAIMetadataRepository,
        @Value("\${youtube.api.key}") private val apiKey: String
) {
    private val restTemplate = RestTemplate()

    // DTO 클래스 (YouTube API 응답을 위한 내부 클래스)
    data class YouTubeSearchResponse(
            val items: List<Item>
    ) {
        data class Item(
                val id: Id,
                val snippet: Snippet
        ) {
            data class Id(
                    @JsonProperty("videoId")
                    val videoId: String
            )

            data class Snippet(
                    val title: String,
                    val publishedAt: String,
                    val thumbnails: Thumbnails,
                    @JsonProperty("channelId")
                    val channelId: String,
                    @JsonProperty("channelTitle")
                    val channelName: String
            ) {
                data class Thumbnails(
                        @JsonProperty("default")
                        val default: Thumbnail
                ) {
                    data class Thumbnail(
                            val url: String
                    )
                }
            }
        }
    }

    /**
     * 채널별 최신 동영상 데이터를 YouTube API로부터 가져와 DB에 저장
     * (여기서는 maxResults=3으로 가져오지만, 필요에 따라 조정 가능)
     */
    fun updateChannelVideos(channelId: String) {
        val url = "https://www.googleapis.com/youtube/v3/search" +
                "?part=snippet" +
                "&channelId=$channelId" +
                "&maxResults=3" + // 동영상 가져올 최대 개수
                "&order=date" +
                "&type=video" +
                "&key=$apiKey"

        try {
            val response = restTemplate.getForObject(url, YouTubeSearchResponse::class.java)
            response?.items?.forEach { item ->
                val videoId = item.id.videoId
                val snippet = item.snippet
                // 파싱: ISO 날짜 포맷으로 변환 (예시)
                val uploadDate = LocalDateTime.parse(snippet.publishedAt, DateTimeFormatter.ISO_DATE_TIME)
                val metadata = niniAIMetadata(
                        videoId = videoId,
                        title = snippet.title,
                        thumbnailUrl = snippet.thumbnails.default.url,
                        uploadDate = uploadDate,
                        channelId = snippet.channelId,
                        channelName = snippet.channelName,
                        channelLogo = null // 채널 로고는 추가 API 호출 등으로 채워질 수 있음
                )
                // DB에 저장 (이미 존재하면 업데이트 로직 추가 가능)
                videoMetadataRepository.save(metadata)
            }
        } catch (e: Exception) {
            println("YouTube API 호출 중 오류 발생: ${e.message}")
        }
    }

    /**
     * 스케줄러: 60분마다 각 채널에 대해 동영상 업데이트 (필요한 채널 ID를 리스트로 관리)
     */
    @Scheduled(fixedRate = 60 * 60 * 1000) // 30분마다 실행
    fun scheduledUpdate() {
        // 예시: 관리할 채널 ID 리스트 (니니아 AI 노래 업로드 채널)
        val channelIds = listOf("UC4JIrW6EmHmZcQb8Ygkz23Q")
        channelIds.forEach { updateChannelVideos(it) }
    }

    /**
     * 캐시된 동영상 리스트를 반환하는 메서드 (Redis 캐시 적용)
     */
    @Cacheable(value = ["niniaiVideos"])
    fun getAllVideos(page: Int, size: Int): List<niniAIVideoDto> {
        val pageable = org.springframework.data.domain.PageRequest.of(page, size)
        val pageResult = videoMetadataRepository.findAll(pageable)
        return pageResult.map { entity ->
            niniAIVideoDto(
                    videoId = entity.videoId,
                    title = entity.title,
                    thumbnailUrl = entity.thumbnailUrl,
                    uploadDate = entity.uploadDate,
                    channelId = entity.channelId,
                    channelName = entity.channelName,
                    channelLogo = entity.channelLogo
            )
        }.toList()
    }

    /**
     * 채널별 동영상 목록 조회
     */
    @Cacheable(value = ["niniaiVideosByChannel"], key = "#channelId")
    fun getVideosByChannel(channelId: String, page: Int, size: Int): List<niniAIVideoDto> {
        val pageable = org.springframework.data.domain.PageRequest.of(page, size)
        val pageResult = videoMetadataRepository.findByChannelId(channelId, pageable)
        return pageResult.map { entity ->
            niniAIVideoDto(
                    videoId = entity.videoId,
                    title = entity.title,
                    thumbnailUrl = entity.thumbnailUrl,
                    uploadDate = entity.uploadDate,
                    channelId = entity.channelId,
                    channelName = entity.channelName,
                    channelLogo = entity.channelLogo
            )
        }.toList()
    }

    /**
     * 단일 동영상 상세 정보 조회
     */
    fun getVideoDetail(videoId: String): niniAIVideoDto? {
        return videoMetadataRepository.findById(videoId).orElse(null)?.let { entity ->
            niniAIVideoDto(
                    videoId = entity.videoId,
                    title = entity.title,
                    thumbnailUrl = entity.thumbnailUrl,
                    uploadDate = entity.uploadDate,
                    channelId = entity.channelId,
                    channelName = entity.channelName,
                    channelLogo = entity.channelLogo
            )
        }
    }
}