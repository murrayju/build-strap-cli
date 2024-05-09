import { getVersion } from 'build-strap';

export default async function printVersion() {
  console.info((await getVersion()).info);
}
