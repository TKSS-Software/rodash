const fs = require('fs')
const mergeFiles = require('merge-files');
const glob = require('glob');
const concat = require("concat")


glob(__dirname + '/../.tmp/source/rodash/**/*.brs', {}, (err, files)=>{
  const outputDirectory = __dirname + '/../dist/source/';
  const outputPath = outputDirectory + 'rodash.brs';
  const inputPathList = files;

  fs.mkdir(outputDirectory, { recursive: true }, (err) => {
    if (err) throw err;

    concat(inputPathList).then((result) => {
      result = result.replace(/rodash_/g, '');
      result = result.replace(/^'import.*\n?/mg, '');

      fs.writeFile(outputPath, result, 'utf8', function (err) {
         if (err) return console.log(err);
      });
    })
  });
})
