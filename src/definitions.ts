import type { PluginListenerHandle } from "@capacitor/core";

export interface ICloudKVPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  set(options: { key: string; value: string }): Promise<void>;
  get(options: { key: string }): Promise<{ value?: string }>;
  addListener(
    eventName: 'icloudSync',
    listenerFunc: (data: { reason: number; keys: string[] }) => void
  ): Promise<PluginListenerHandle>;
}
