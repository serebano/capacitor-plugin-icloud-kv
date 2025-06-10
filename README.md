# @serebano/capacitor-plugin-icloud-kv

Capacitor 7 plugin for syncing simple key‑value preferences across iCloud on iOS.

## Install

```bash
npm install @serebano/capacitor-plugin-icloud-kv
npx cap sync
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
