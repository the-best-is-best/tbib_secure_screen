package com.example.tbib_secure_screen

import android.app.Activity
import android.os.Build
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TbibSecureScreenPlugin */
class TbibSecureScreenPlugin : MethodCallHandler, FlutterPlugin, ActivityAware {
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel

    constructor() // Default constructor

    constructor(activity: Activity) {
        this.activity = activity
    }

    private fun setupChannel(binaryMessenger: BinaryMessenger) {
        channel = MethodChannel(binaryMessenger, "tbib_secure_screen")
        channel.setMethodCallHandler(this)
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setupChannel(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        // Clean up resources if needed
    }

   

    override fun onMethodCall(call: MethodCall, result: Result) {
        // val flags = call.argument<Int>("flags") ?: 0

        if (activity == null) {
            result.error(
                "FlutterWindowManagerPlugin",
                "FlutterWindowManagerPlugin: ignored flag state change, current activity is null",
                null
            )
        }


        when (call.method) {
            "setSecureScreen" -> {
                activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                result.success(true)
            }
            "setUnSecureScreen" -> {
                activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        activity = activityPluginBinding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
        onAttachedToActivity(activityPluginBinding)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
