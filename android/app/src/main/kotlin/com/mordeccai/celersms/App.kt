package com.mordeccai.celersms

import android.app.Application
import android.content.res.Configuration
import com.androidnetworking.AndroidNetworking
import io.flutter.app.FlutterApplication
import com.evernote.android.job.JobManager




class CelerSmsApp : FlutterApplication() {
    // Called when the application is starting, before any other application objects have been created.
    // Overriding this method is totally optional!
    override fun onCreate() {
        super.onCreate()
        AndroidNetworking.initialize(getApplicationContext());
        JobManager.create(this).addJobCreator(MessageSyncJobCreator())
    }

    // Called by the system when the device configuration changes while your component is running.
    // Overriding this method is totally optional!
    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
    }

    // This is called when the overall system is running low on memory,
    // and would like actively running processes to tighten their belts.
    // Overriding this method is totally optional!
    override fun onLowMemory() {
        super.onLowMemory()
    }
}