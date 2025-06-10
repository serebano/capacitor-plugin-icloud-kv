# @serebano/capacitor-plugin-icloud-kv

Capacitor 7 plugin for syncing simple key‑value preferences across iCloud on iOS.

## Install

```bash
npm install @serebano/capacitor-plugin-icloud-kv
npx cap sync
```

## ⚙️ iOS Setup

Enable iCloud + Key-Value Storage in Xcode:

1. Open `ios/App.xcworkspace`.
2. Select your app target → Signing & Capabilities.
3. Add **iCloud** capability and check **Key‑Value Storage**.

## 📦 Usage

```ts
import { ICloudKV } from '@serebano/capacitor-plugin-icloud-kv';

ICloudKV.addListener('icloudSync', data => {
  console.log('Synced keys:', data.keys, 'reason:', data.reason);
});

await ICloudKV.set({ key: 'theme', value: 'dark' });
const result = await ICloudKV.get({ key: 'theme' });
console.log('Theme:', result.value);
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`set(...)`](#set)
* [`get(...)`](#get)
* [`addListener('icloudSync', ...)`](#addlistenericloudsync-)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### set(...)

```typescript
set(options: { key: string; value: string; }) => Promise<void>
```

| Param         | Type                                         |
| ------------- | -------------------------------------------- |
| **`options`** | <code>{ key: string; value: string; }</code> |

--------------------


### get(...)

```typescript
get(options: { key: string; }) => Promise<{ value?: string; }>
```

| Param         | Type                          |
| ------------- | ----------------------------- |
| **`options`** | <code>{ key: string; }</code> |

**Returns:** <code>Promise&lt;{ value?: string; }&gt;</code>

--------------------


### addListener('icloudSync', ...)

```typescript
addListener(eventName: 'icloudSync', listenerFunc: (data: { reason: number; keys: string[]; }) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                |
| ------------------ | ------------------------------------------------------------------- |
| **`eventName`**    | <code>'icloudSync'</code>                                           |
| **`listenerFunc`** | <code>(data: { reason: number; keys: string[]; }) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### Interfaces


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |

</docgen-api>