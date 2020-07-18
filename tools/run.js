import { run, handleEntryPoint, setPkg, setRoot } from 'build-strap';
import path from 'path';
import pkg from '../package.json';

setRoot(path.resolve(__dirname, '../'));
setPkg(pkg);
handleEntryPoint(module, __filename, {
  // eslint-disable-next-line import/no-dynamic-require,global-require
  resolveFn: (p) => require(`./${p}`).default,
});

export default run;
