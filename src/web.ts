import { WebPlugin } from '@capacitor/core';

import type { ICloudKVPlugin } from './definitions';

export class ICloudKVWeb extends WebPlugin implements ICloudKVPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
