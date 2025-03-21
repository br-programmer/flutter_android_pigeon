package dev.brprogrammer.qr.biometrics.app

import androidx.annotation.NonNull
import dev.brprogrammer.qr.biometrics.app.biometric.IBiometricsApi
import dev.brprogrammer.qr.biometrics.app.biometric.BiometricsApi
import dev.brprogrammer.qr.biometrics.app.scanner.IQrScannerApi
import dev.brprogrammer.qr.biometrics.app.scanner.QrScannerApi
import dev.brprogrammer.qr.biometrics.app.session.ISessionApi
import dev.brprogrammer.qr.biometrics.app.session.SessionApi
import dev.brprogrammer.qr.biometrics.app.storage.ILocalStorageApi
import dev.brprogrammer.qr.biometrics.app.storage.LocalStorageApi
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger
        IBiometricsApi.setUp(messenger, BiometricsApi(this))
        ISessionApi.setUp(messenger, SessionApi(this))
        ILocalStorageApi.setUp(messenger, LocalStorageApi(this))
        IQrScannerApi.setUp(messenger, QrScannerApi(this))
    }
}
