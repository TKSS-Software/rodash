const fs = require('fs')
const mergeFiles = require('merge-files');
const glob = require('glob');
const concat = require("concat")
const copyfiles = require('copyfiles');


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

        glob(__dirname + '/../.tmp/source/rodash/**/*.d.bs', {}, (err, files) => {
          files.forEach((path) => {
            var fileName = path.split("/").pop();
            if (!fileName.includes("_")) {
              fs.readFile(path, 'utf8', function (err,data) {
                if (err) {
                  return console.log(err);
                }
                var result = data
                var hasInternal = result.includes("namespace rodash.internal")
                console.log("hasInternal", hasInternal)
                
                if (hasInternal) {
                  result = result.replace("namespace rodash.", 'namespace ');
                } else {
                  result = result.replace(/^.*namespace.*$/gm, '');
                }
                fs.writeFile(outputDirectory + fileName, result, 'utf8', function (err) {
                  if (err) return console.log(err);
                  console.log(fileName + ' was copied to ' + fileName);
                });
              });
            }
          });
        })
      });
    })
  });
})
