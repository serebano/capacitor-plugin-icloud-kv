export interface ICloudKVPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
