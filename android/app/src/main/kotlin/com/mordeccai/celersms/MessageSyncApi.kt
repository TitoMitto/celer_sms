package com.mordeccai.celersms

import android.content.Context
import android.util.Log
import com.mordeccai.celersms.data.AppDatabase
import com.mordeccai.celersms.data.models.Message
import com.androidnetworking.error.ANError
import org.json.JSONObject
import com.androidnetworking.interfaces.JSONObjectRequestListener
import com.androidnetworking.AndroidNetworking
import com.androidnetworking.common.Priority


class MessageSyncApi(val context: Context, val db: AppDatabase) {

    fun sync(messages: List<Message>){
        val apiUrl = getApiUrl()
        val phoneNumber = getSettings("phoneNumber")
        messages.forEach {
            AndroidNetworking.post(apiUrl)
                    .addBodyParameter("from", it.address)
                    .addBodyParameter("message_body", it.body)
                    .addBodyParameter("date_sent", "${it.dateSent}")
                    .addBodyParameter("date_received", "${it.date}")
                    .addBodyParameter("service_center", it.serviceCenter)
                    .addBodyParameter("message_id", "${it.id}")
                    .addBodyParameter("uuid", "${it.id}")
                    .addBodyParameter("to", phoneNumber)
                    .setTag("MESSAGE_SYNC_API")
                    .setPriority(Priority.HIGH)
                    .build()
                    .getAsJSONObject(object : JSONObjectRequestListener {
                        override fun onResponse(response: JSONObject) {
                            db.messageDao().update(
                                    it.copy(synced = 1)
                            )
                            Log.d("SYNC_SUCCESSFUL", "msg_id ${it.id} synced")
                        }

                        override fun onError(error: ANError) {
                            // handle error
                            Log.e("SYNC_ERROR", "$error")
                        }
                    })
        }
    }

    fun getSettings(name: String): String {
        val prefs = context.getSharedPreferences("CelerSmsSettings", Context.MODE_PRIVATE)
        val settings = prefs.getString(name, "")
        Log.d("SETTINGS_$name", settings)
        return settings
    }

    fun getApiUrl(): String {
        val userSettingsString = getSettings("settings")
        var apiUrl = ""
        lateinit var userSettings: JSONObject
        if(userSettingsString != ""){
           userSettings = JSONObject(userSettingsString)
            apiUrl = userSettings.get("apiUrl").toString()
        }
        Log.d("API_URL", apiUrl)
        return apiUrl
    }
}