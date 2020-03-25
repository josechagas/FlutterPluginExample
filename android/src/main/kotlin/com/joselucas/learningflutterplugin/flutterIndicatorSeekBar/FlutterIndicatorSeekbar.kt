package com.joselucas.learningflutterplugin.flutterIndicatorSeekBar

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.view.View
import android.widget.TextView
import com.warkiz.widget.IndicatorSeekBar
import com.warkiz.widget.IndicatorType
import com.warkiz.widget.TickMarkType
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class FlutterIndicatorSeekbar internal constructor(private val context: Context?,private val id: Int, private val args:Any?) : PlatformView {
    private var indicatorBar: IndicatorSeekBar? = null

    companion object {
        const val ViewType:String = "learning_flutter_plugin/indicator_seek_bar"
    }

    init {
        createView()
    }

    override fun dispose() {
        indicatorBar = null
    }

    override fun getView(): View {
        if(indicatorBar == null)
            createView()
        return indicatorBar ?: View(context)
    }

    private fun createView(){
        context?.let {
            val builder = IndicatorSeekBar
                    .with(it)

            var max = 100.0
            var min = 0.0
            var progress = 0.0
            var tickCount = 1
            (args as? HashMap<String,*>)?.let { mapArgs ->
                max = mapArgs["max"] as? Double ?: max
                min = mapArgs["min"] as? Double ?: min
                progress = mapArgs["progress"] as? Double ?: progress
                tickCount = mapArgs["tickCount"] as? Int ?: tickCount
            }

            builder
                    .max(max.toFloat())
                    .min(min.toFloat())
                    .progress(progress.toFloat())
                    .tickCount(tickCount)
                    .showTickMarksType(TickMarkType.OVAL)
                    .tickMarksSize(13)//dp
                    .showTickTexts(true)
                    .tickTextsSize(13)//sp
                    .tickTextsTypeFace(Typeface.MONOSPACE)
                    .showIndicatorType(IndicatorType.ROUNDED_RECTANGLE)
                    .indicatorTextColor(Color.parseColor("#ffffff"))
                    .indicatorTextSize(13)//sp
                    .thumbSize(14)
                    .trackProgressSize(4)
                    .trackBackgroundSize(2)
                    .onlyThumbDraggable(false)


            indicatorBar = builder.build()
            indicatorBar?.tag = id
        }
    }
}

class IndicatorSeekbarFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return FlutterIndicatorSeekbar(context, viewId, args)
    }
}