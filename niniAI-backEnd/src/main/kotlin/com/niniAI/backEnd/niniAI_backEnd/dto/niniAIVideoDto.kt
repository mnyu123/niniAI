package com.niniAI.backEnd.niniAI_backEnd.dto

import com.fasterxml.jackson.annotation.JsonFormat
import java.time.LocalDateTime

data class niniAIVideoDto(
        val videoId: String,
        val title: String,
        val thumbnailUrl: String,
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
        val uploadDate: LocalDateTime,
        val channelId: String,
        val channelName: String,
        val channelLogo: String?
)