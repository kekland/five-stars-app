package com.kekland.five_stars;

import android.content.Context;

import androidx.multidex.MultiDex;
import io.flutter.app.FlutterApplication;

public class FiveStarsApplication extends FlutterApplication {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
