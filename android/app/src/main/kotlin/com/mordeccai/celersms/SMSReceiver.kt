package com.mordeccai.celersms

import android.annotation.TargetApi
import android.support.v4.app.NotificationCompat.getExtras
import android.os.Bundle
import android.content.Intent
import android.content.BroadcastReceiver
import android.content.Context
import android.os.Build
import android.provider.Telephony
import android.telephony.SmsManager
import android.telephony.SmsMessage
import android.util.Log
import com.mordeccai.celersms.data.AppDatabase
import com.mordeccai.celersms.data.models.Message
import com.mordeccai.celersms.utils.TelephonyCompat
import org.json.JSONObject
import java.util.*


class SMSReceiver : BroadcastReceiver() {

    @TargetApi(Build.VERSION_CODES.KITKAT)
    private fun readMessages(intent: Intent): Array<SmsMessage> {
        return Telephony.Sms.Intents.getMessagesFromIntent(intent)
    }

    override fun onReceive(context: Context, intent: Intent) {
        val db = AppDatabase.instance(context)
        Log.d("MSG_RECEIVER_RECEIVED", "Received")
        try {
            val msgs = readMessages(intent) ?: return
            val message = mutableMapOf<String, Any>(
                    "address" to msgs[0].originatingAddress,
                    "date" to Date().time,
                    "date_sent" to msgs[0].timestampMillis,
                    "read" to if (msgs[0].statusOnIcc == SmsManager.STATUS_ON_ICC_READ) 1 else 0,
                    "thread_id" to TelephonyCompat.getOrCreateThreadId(context, msgs[0].originatingAddress),
                    "service_center" to msgs[0].serviceCenterAddress,
                    "uuid" to msgs[0].hashCode()
            )

            var body = ""
            for (msg in msgs) {
                body = body + msg.messageBody
            }
            message["body"] = body
            Log.d("MSG_RECEIVED", message.toString())
            db.messageDao().insert(Message(
                address = msgs[0].originatingAddress,
                date = Date().time,
                dateSent = msgs[0].timestampMillis,
                read = if (msgs[0].statusOnIcc == SmsManager.STATUS_ON_ICC_READ) 1 else 0,
                threadId = message["thread_id"] as Long,
                serviceCenter = message["service_center"] as String,
                body = message["body"] as String,
                synced = 0,
                uuid = message["uuid"] as  Int
            ))
            MessageSyncJob.scheduleJob()

        } catch (e: Exception) {
            Log.d("SmsReceiver", e.toString())
        }
    }

    companion object {
        private val LOG_TAG = "SMSApp"
        /* package */
        internal val ACTION = "android.provider.Telephony.SMS_RECEIVED"
    }
}