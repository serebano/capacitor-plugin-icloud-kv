package serebano.capacitor.plugin.icloud.kv;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "ICloudKV")
public class ICloudKVPlugin extends Plugin {

    private ICloudKV implementation = new ICloudKV();

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

    @PluginMethod
    public void set(PluginCall call) {
        call.unimplemented("Not supported on Android.");
    }

    @PluginMethod
    public void get(PluginCall call) {
        call.unimplemented("Not supported on Android.");
    }
}
