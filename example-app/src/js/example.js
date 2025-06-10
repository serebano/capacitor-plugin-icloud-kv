import { ICloudKV } from '@serebano/capacitor-plugin-icloud-kv';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    ICloudKV.echo({ value: inputValue })
}
