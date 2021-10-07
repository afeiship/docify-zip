#!/usr/bin/env node
const { Command } = require('commander');
const chalk = require('chalk');
const fs = require('fs');
const path = require('path');

// next packages:
require('@jswork/next');
require('@jswork/next-absolute-package');
require('@jswork/next-node-downfile');

const { version } = nx.absolutePackage();
const program = new Command();
const exec = require('child_process').execSync;
const QUICK_URL = 'https://github.91chifun.workers.dev';
const FILES_URL = `${QUICK_URL}/https://github.com/afeiship/docify-zip/archive/refs/heads/master.zip`;
const TARGET_FILES = '/tmp/docify-zip-master/files/';

const basename = (inFilename) => {
  const isDir = fs.lstatSync(inFilename).isDirectory();
  if (isDir) return path.basename(inFilename);
  const extname = path.extname(inFilename);
  return path.basename(inFilename, extname);
};

program.version(version);

program
  .option('-d, --debug', 'only show cmds, but not clean.')
  .option('-f, --filename <string>', 'The zip target filename.')
  .option('-p, --password <string>', 'The zip password.')
  .option('-s, --src <string>', 'source filepath.', './src')
  .parse(process.argv);

nx.declare({
  statics: {
    init() {
      const app = new this();
      app.start();
    }
  },
  methods: {
    init() {},
    async start() {
      await nx.nodeDownfile({
        url: FILES_URL,
        filename: `/tmp/docify-zip.zip`
      });
      const name = basename(program.filename);
      const command = program.password ? ` --password ${password}` : '';

      exec(`cd /tmp && unzip docify-zip.zip`);
      exec(`zip -jq '${name}${suffix}.zip' ${program.filename} ${TARGET_FILES}/* ${command}`);
      // /tmp/docify-zip-master/files/
      // console.log(chalk.green('🚗 hello cli.'), program.src, program.debug);
    }
  }
});
