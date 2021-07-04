import { run, handleEntryPoint, setPkg } from 'build-strap';
import pkg from '../package.json';

setPkg(pkg);
handleEntryPoint(module, __filename, {
  // eslint-disable-next-line import/no-dynamic-require,global-require
  resolveFn: (p) => require(`./${p}`).default,
});

export default run;
