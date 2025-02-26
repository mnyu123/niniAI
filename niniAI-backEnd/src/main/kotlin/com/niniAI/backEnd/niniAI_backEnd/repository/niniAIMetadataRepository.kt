package com.niniAI.backEnd.niniAI_backEnd.repository

import com.niniAI.backEnd.niniAI_backEnd.entity.niniAIMetadata
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository

interface niniAIMetadataRepository : JpaRepository<niniAIMetadata, String> {
    // 채널별 페이징 조회
    fun findByChannelId(channelId: String, pageable: Pageable): Page<niniAIMetadata>
}