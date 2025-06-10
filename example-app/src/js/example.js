import { ICloudKV } from '@serebano/capacitor-plugin-icloud-kv';

async function main() {
  console.log('[ICloudKV]', 'Starting...');
const listener = await ICloudKV.addListener('icloudSync', async (data) => {
  console.log('[ICloudKV]', 'Synced keys:', data.keys, 'reason:', data.reason);
  for (const key of data.keys) {
    const result = await ICloudKV.get({ key });
    console.log('[ICloudKV]', 'Key:', key, 'Value:', result.value);
  }
});

const listener2 = await ICloudKV.addListener('echo', data => {
  console.log('[ICloudKV]', 'Echo:', data.value);
});

// await ICloudKV.set({ key: 'theme', value: 'dark' });
const result = await ICloudKV.get({ key: 'theme' });
console.log('[ICloudKV]', 'Theme:', result.value);

Object.assign(globalThis, {ICloudKV, listener, listener2})

}

window.testEcho = async () => {
    const inputValue = document.getElementById("echoInput").value;
    await ICloudKV.set({ key: 'theme', value: inputValue });

    await ICloudKV.echo({ value: inputValue })
}

main();
