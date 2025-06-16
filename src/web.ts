import { WebPlugin } from '@capacitor/core';

import type { ICloudKVPlugin, ICloudKVValue } from './definitions';

export class ICloudKVWeb extends WebPlugin implements ICloudKVPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
  async set(_options: { key: string; value: ICloudKVValue }): Promise<void> {
    throw this.unimplemented('Not supported on web.');
  }
  async get(_options: { key: string }): Promise<{ value?: ICloudKVValue }> {
    throw this.unimplemented('Not supported on web.');
  }
  async remove(_options: { key: string }): Promise<void> {
    throw this.unimplemented('Not supported on web.');
  }
}
