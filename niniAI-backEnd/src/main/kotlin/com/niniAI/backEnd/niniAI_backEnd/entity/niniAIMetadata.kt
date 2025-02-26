package com.niniAI.backEnd.niniAI_backEnd.entity

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "niniAI_video_metadata")
data class niniAIMetadata(
        @Id
        @Column(name = "video_id", nullable = false)
        val videoId: String,

        @Column(name = "title", nullable = false)
        val title: String,

        @Column(name = "thumbnail_url", nullable = false)
        val thumbnailUrl: String,

        @Column(name = "upload_date", nullable = false)
        val uploadDate: LocalDateTime,

        @Column(name = "channel_id", nullable = false)
        val channelId: String,

        @Column(name = "channel_name", nullable = false)
        val channelName: String,

        @Column(name = "channel_logo", nullable = true)
        val channelLogo: String?
)