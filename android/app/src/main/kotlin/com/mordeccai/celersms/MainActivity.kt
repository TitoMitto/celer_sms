package com.mordeccai.celersms

import android.content.Context
import android.os.Bundle
import android.telephony.SmsManager
import android.util.Log
import com.mordeccai.celersms.data.AppDatabase
import com.mordeccai.celersms.data.models.Message
import com.mordeccai.celersms.utils.TelephonyCompat

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*

class MainActivity(): FlutterActivity() {
  companion object {
    const val CHANNEL:  String = "celer_sms.mordeccai.com/messenger"
  }
  lateinit var db: AppDatabase
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    db = AppDatabase.instance(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      when(call.method){
        "storeSettings" -> {
          val key: String = call.argument("key")
          val value: String = call.argument("value")
          storeSettings(key, value, result)
        }
        "getSettings" -> {
          Log.d("KEY_LOG", "${call.arguments}")
          val key: String = call.argument("key")
          getSettings(key, result)
        }
        "getAllMessages" -> {
          getAllMessages(result)
        }
      }
    }
  }

  fun storeSettings(key: String, value: String, result: MethodChannel.Result) {
    val editor = getSharedPreferences("CelerSmsSettings", Context.MODE_PRIVATE).edit()
    editor.putString(key, value)
    editor.apply()
    result.success(true)
  }

  fun getSettings(key: String, result: MethodChannel.Result) {
    val prefs = getSharedPreferences("CelerSmsSettings", Context.MODE_PRIVATE)
    val info = prefs.getString(key, "")
    Log.d("VALUE_LOG", info)
    result.success(info)
  }

  fun getAllMessages( result: MethodChannel.Result){
    val messages: List<Message> = db.messageDao().findAll()
    val msgs: MutableList<MutableMap<String, Any>> = mutableListOf()
    messages.forEach { it ->
      msgs.add(mutableMapOf<String, Any>(
              "address" to it.address,
              "date" to it.date.toString(),
              "date_sent" to it.dateSent.toString(),
              "read" to it.read,
              "body" to it.body,
              "synced" to it.synced,
              "thread_id" to it.threadId,
              "service_center" to it.serviceCenter,
              "uuid" to it.uuid
      ))
    }
    result.success(msgs)
  }
}
