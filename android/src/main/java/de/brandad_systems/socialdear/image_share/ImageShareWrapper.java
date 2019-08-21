package de.brandad_systems.socialdear.image_share;

import android.content.Context;
import android.content.pm.PackageManager;
import android.net.Uri;

import java.io.File;
import java.util.Map;

import android.content.Intent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import androidx.core.content.FileProvider;


public class ImageShareWrapper implements MethodCallHandler {
    private static final String PATH = "path";
    private static final  String ANDROID_ID = "ANDROID_ID";
    private final Registrar mRegistrar;


    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "de/brandad-systems/socialdear/image_share");
        channel.setMethodCallHandler(new ImageShareWrapper(registrar));
    }

    private ImageShareWrapper(Registrar registrar) {
        this.mRegistrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "share":
                if (!(call.arguments instanceof Map)) {
                    throw new IllegalArgumentException("Map argument expected");
                }
                // Android does not support showing the share sheet at a particular point on screen.
                share((String) call.argument(PATH),(String) call.argument(ANDROID_ID));


                result.success(null);
                break;
            case "isPackageInstalled":
                result.success(isPackageInstalled((String) call.argument(ANDROID_ID)));
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void share(String path,String packageId) {
        String TYPE = "image/*";

        Context context = mRegistrar.context();
        Intent shareIntent = new Intent();
        shareIntent.setAction(Intent.ACTION_SEND);

        File newFile = new File(path);
        Uri contentUri = FileProvider.getUriForFile(context, "de.brandad_systems.socialdear.image_share.provider", newFile);

        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);
        shareIntent.setType(TYPE);
        shareIntent.setPackage(packageId);

        if (mRegistrar.activity() != null) {
            mRegistrar.activity().startActivity(shareIntent);
        } else {
            shareIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            mRegistrar.context().startActivity(shareIntent);
        }
    }


    private boolean isPackageInstalled(String packageId) {
        PackageManager manager = (mRegistrar.context().getPackageManager());
        try {
            manager.getPackageInfo(packageId, PackageManager.GET_ACTIVITIES);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }
}
