import type { PluginListenerHandle } from "@capacitor/core";

/**
 * Sync reason codes
 */
export enum ICloudKVSyncReason {
  /**
   * Change came from iCloud
   */
  SERVER_CHANGE = 0,
  /**
   * Initial sync occurred
   */
  INITIAL_SYNC_CHANGE = 1,
  /**
   * Change removed due to quota violations
   */
  QUOTA_VIOLATION_CHANGE = 2,
  /**
   * iCloud account changed
   */
  ACCOUNT_CHANGE = 3
}

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
