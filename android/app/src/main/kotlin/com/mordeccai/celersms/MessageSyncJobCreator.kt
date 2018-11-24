package com.mordeccai.celersms

import android.content.Context
import com.evernote.android.job.JobManager
import com.evernote.android.job.JobCreator.AddJobCreatorReceiver
import android.content.ContentValues.TAG
import android.support.annotation.NonNull
import android.support.annotation.Nullable
import com.evernote.android.job.Job
import com.evernote.android.job.JobCreator


class MessageSyncJobCreator() : JobCreator {

    @Nullable
    override fun create(tag: String): Job? {
        when (tag) {
            MessageSyncJob.TAG -> return MessageSyncJob()
            else -> return null
        }
    }
}