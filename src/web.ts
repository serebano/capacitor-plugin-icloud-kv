import { WebPlugin } from '@capacitor/core';

import type { ICloudKVPlugin } from './definitions';

export class ICloudKVWeb extends WebPlugin implements ICloudKVPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
  async set(): Promise<void> {
    throw this.unimplemented('Not supported on web.');
  }
  async get(): Promise<{ value?: string }> {
    throw this.unimplemented('Not supported on web.');
  }
}
