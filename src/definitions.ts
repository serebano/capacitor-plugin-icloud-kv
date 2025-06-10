import type { PluginListenerHandle } from "@capacitor/core";

/**
 * @see https://github.com/serebano/capacitor-plugin-icloud-kv#icloudkvdidsyncreason
 * ```
 * 1 - Initial sync from iCloud
 * 2 - External change from another device
 * 3 - Change due to server push
 * ```
 */
export enum ICloudKVSyncReason {
  INITIAL_SYNC = 1,
  EXTERNAL_CHANGE = 2,
  SERVER_PUSH = 3
}


/**
 * Reason Codes (Apple-defined)
 *
 * The reason you get is an integer, which maps to:
 * ```
 * 1 — Initial sync from iCloud
 * 2 — External change from another device
 * 3 — Change due to server push
 * ```
 *
 * Apple doesn't provide official constants, so you'll interpret them manually.
 */

/**
 * Supported data types for iCloud Key-Value storage
 * These correspond to the types supported by NSUbiquitousKeyValueStore
 */
export type ICloudKVValue =
  | string
  | number
  | boolean
  | Date
  | ICloudKVValue[]
  | { [key: string]: ICloudKVValue }

export interface ICloudKVPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  set(options: { key: string; value: ICloudKVValue }): Promise<void>;
  get(options: { key: string }): Promise<{ value?: ICloudKVValue }>;
  addListener(
    eventName: 'icloudKVDidChange',
    listenerFunc: (data: { reason: ICloudKVSyncReason; keys: string[] }) => void
  ): Promise<PluginListenerHandle>;
}
