package com.mordeccai.celersms

import android.content.Context
import com.evernote.android.job.JobManager
import com.evernote.android.job.JobCreator.AddJobCreatorReceiver
import android.content.ContentValues.TAG
import android.support.annotation.NonNull
import android.support.annotation.Nullable
import com.evernote.android.job.Job
import com.evernote.android.job.JobCreator
import com.evernote.android.job.JobRequest
import com.mordeccai.celersms.data.AppDatabase
import com.mordeccai.celersms.data.models.Message
import android.content.ContentValues.TAG




class MessageSyncJob(): Job() {

    override fun onRunJob(params: Job.Params): Job.Result {
        val db = AppDatabase.instance(context)
        // run your job here
        val messages: List<Message> = db.messageDao().findMessageBySynced(0)
        if (messages.size > 0) {
            MessageSyncApi(context, db).sync(messages)
        }

        return Job.Result.SUCCESS
    }

    companion object {
        val TAG = "MESSAGE_SYNC_JOB"

        fun scheduleJob() {
            val jobRequests = JobManager.instance().getAllJobRequestsForTag(MessageSyncJob.TAG)
            if (!jobRequests.isEmpty()) {
                return
            }
            JobRequest.Builder(MessageSyncJob.TAG)
                    .setExecutionWindow(1_000L, 10_000L)
                    .setRequiredNetworkType(JobRequest.NetworkType.CONNECTED)
                    .setRequirementsEnforced(true)
                    .build()
                    .schedule()
        }
    }
}