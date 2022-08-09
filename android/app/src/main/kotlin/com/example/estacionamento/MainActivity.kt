package com.example.estacionamento

import android.os.Bundle
import com.mercadopago.android.px.core.MercadoPagoCheckout
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val REQUEST_CODE = 1
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initFlutterChannels()
    }

    private fun initFlutterChannels() {
        val channelMercadoPago = MethodChannel(getFlutterEngine()!!.getDartExecutor(), "example.com/mercadoPago")

        channelMercadoPago.setMethodCallHandler { methodCall, result ->
            val args = methodCall.arguments as HashMap<String, Any>
            val publicKey = args["publicKey"] as String
            val preferenceId = args["preferenceId"] as String

            when(methodCall. method) {
                "mercadoPago" -> mercadoPago(publicKey, preferenceId, result)
                else -> return@setMethodCallHandler
            }
        }
    }
    private fun mercadoPago(publicKey: String, preferenceId: String, channelResult: MethodChannel.Result) {
        MercadoPagoCheckout.Builder(publicKey, preferenceId)
                .build()
                .startPayment(this@MainActivity, REQUEST_CODE)
    }
}
