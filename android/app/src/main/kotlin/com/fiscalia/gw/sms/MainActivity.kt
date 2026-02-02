package com.fiscalia.gw_sms

import android.Manifest
import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageManager
import android.telephony.SmsManager
import android.util.Log
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.fiscalia.gw_sms/sms"
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "sendSMS" -> {
                    val phoneNumber = call.argument<String>("phoneNumber")
                    val message = call.argument<String>("message")
                    val simSlot = call.argument<Int>("simSlot") ?: 0
                    
                    if (phoneNumber != null && message != null) {
                        val sent = sendSMS(phoneNumber, message, simSlot)
                        result.success(sent)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Phone number or message is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun sendSMS(phoneNumber: String, message: String, simSlot: Int): Boolean {
        return try {
            Log.d(TAG, "📱 Enviando SMS a: $phoneNumber")
            Log.d(TAG, "💬 Mensaje: $message")
            Log.d(TAG, "📡 SIM slot: $simSlot")
            
            // Verificar permisos
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS) 
                != PackageManager.PERMISSION_GRANTED) {
                Log.e(TAG, "❌ Permiso SEND_SMS no otorgado")
                return false
            }
            
            val smsManager = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP_MR1) {
                // Para Android 5.1+, usar SmsManager con subscription ID
                val subscriptionManager = android.telephony.SubscriptionManager.from(this)
                val subscriptionInfoList = subscriptionManager.activeSubscriptionInfoList
                
                if (subscriptionInfoList != null && subscriptionInfoList.isNotEmpty()) {
                    // Obtener el subscription ID del slot especificado
                    val subscriptionId = if (simSlot < subscriptionInfoList.size) {
                        subscriptionInfoList[simSlot].subscriptionId
                    } else {
                        subscriptionInfoList[0].subscriptionId
                    }
                    
                    Log.d(TAG, "📡 Usando subscription ID: $subscriptionId")
                    SmsManager.getSmsManagerForSubscriptionId(subscriptionId)
                } else {
                    SmsManager.getDefault()
                }
            } else {
                SmsManager.getDefault()
            }
            
            // Enviar SMS
            val sentPI = PendingIntent.getBroadcast(
                this, 0, Intent("SMS_SENT"), 
                PendingIntent.FLAG_IMMUTABLE
            )
            
            smsManager.sendTextMessage(phoneNumber, null, message, sentPI, null)
            
            Log.d(TAG, "✅ SMS enviado exitosamente")
            true
        } catch (e: Exception) {
            Log.e(TAG, "❌ Error al enviar SMS: ${e.message}", e)
            false
        }
    }
}
