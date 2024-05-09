import { run, publish, getVersion, buildLog } from 'build-strap';
import copy from './copy';

export default async function doPublish() {
  if (process.argv.includes('--watch')) {
    buildLog('`--watch` option is not compatible with publish.');
    return;
  }
  const version = await getVersion();

  let reallyPublish = process.argv.includes('--force-publish');
  if (!reallyPublish && process.argv.includes('--publish')) {
    if (parseInt(version.build, 10) === 0) {
      buildLog(
        'Ignoring --publish for dev build (build number is 0). Use --force-publish to override.',
      );
    } else {
      reallyPublish = true;
    }
  }

  if (!process.argv.includes('--publish-only')) {
    await run(copy);
  }
  await publish({
    distDir: './dist',
    outDir: './out',
    doPublish: reallyPublish,
  });
}
