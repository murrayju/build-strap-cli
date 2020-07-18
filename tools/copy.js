import { getPkg, getVersion, writeFile, copyFile, makeDir } from 'build-strap';
import path from 'path';

/**
 * Copies everything to the dist folder that we want to publish
 */
export default async function copy() {
  const distDir = './dist';
  await makeDir(distDir);
  const version = await getVersion();
  const {
    name,
    description,
    license,
    authors,
    repository,
    homepage,
    bin,
  } = getPkg();
  await Promise.all([
    ...[
      'LICENSE',
      'README.md',
      '.yarnrc',
      'bs',
      'bs.bat',
      'bs.ps1',
      'node',
      'node.bat',
      'node.ps1',
      'nodeBootstrap.sh',
      'nodeBootstrap.ps1',
      'yarn',
      'yarn.bat',
      'yarn.ps1',
    ].map((f) => copyFile(f, path.join(distDir, f))),
    writeFile(
      path.join(distDir, 'package.json'),
      JSON.stringify(
        {
          name,
          version: version.npm,
          description,
          license,
          authors,
          repository,
          homepage,
          bin,
        },
        null,
        2,
      ),
    ),
  ]);
}
