package com.example.app

import android.content.Context
import android.content.Context.ACCESSIBILITY_SERVICE
import android.util.Log
import android.view.accessibility.AccessibilityManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ScreenReaderPlugin {

    private enum class MethodChannelType(val value: String) {
        SCREEN_READER("com.example.app/method/screenReader"),
        ;

        enum class MethodNameType(val value: String) {
            FETCH_ENABLE("fetchEnable"),
            ;
        }
    }

    private enum class EventChannelType(val value: String) {
        SCREEN_READER_FETCH_ENABLE("com.example.app/event/screenReader/fetchEnable"),
        ;
    }

    companion object {
        private const val TAG = "ScreenReaderPlugin"

        private var fetchEnableEventSink: EventChannel.EventSink? = null

        fun configure(context: Context, flutterEngine: FlutterEngine) {
            /**
             * MethodChannel
             * https://docs.flutter.dev/development/platform-integration/platform-channels#step-3-add-an-android-platform-specific-implementation
             */
            val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MethodChannelType.SCREEN_READER.value)
            methodChannel.setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
                when (methodCall.method) {
                    MethodChannelType.MethodNameType.FETCH_ENABLE.value -> {
                        val value = (context.getSystemService(ACCESSIBILITY_SERVICE) as? AccessibilityManager).let {
                            if (it != null) {
                                return@let it.isTouchExplorationEnabled
                            } else {
                                return@let false
                            }
                        }
                        Log.i(TAG, "fetchEnable: $value")
                        result.success(value)
                    }
                    else -> {
                        Log.e(TAG, "notImplemented")
                        result.notImplemented()
                    }
                }
            }

            /**
             * EventChannel
             */
            val fetchEnableEventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EventChannelType.SCREEN_READER_FETCH_ENABLE.value)
            val touchExplorationStateChangeListener = AccessibilityManager.TouchExplorationStateChangeListener {
                Log.i(TAG, "fetchEnable with EventChannel: $it")
                fetchEnableEventSink?.success(it)
            }
            fetchEnableEventChannel.setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink) {
                    fetchEnableEventSink = sink
                    val am = (context.getSystemService(ACCESSIBILITY_SERVICE) as? AccessibilityManager)
                    am?.also {
                        it.addTouchExplorationStateChangeListener(touchExplorationStateChangeListener)
                    }
                }

                override fun onCancel(arguments: Any?) {
                    fetchEnableEventSink = null
                    val am = (context.getSystemService(ACCESSIBILITY_SERVICE) as? AccessibilityManager)
                    am?.also {
                        it.removeTouchExplorationStateChangeListener(touchExplorationStateChangeListener)
                    }
                }
            })
        }
    }
}
