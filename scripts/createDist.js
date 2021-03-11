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
          var output = ""
          var outputs = {
            "rodash": ""
          }

          files.forEach((path) => {
            var fileName = path.split("/").pop();
            if (!fileName.includes("_")) {
              fs.readFile(path, 'utf8', function (err,data) {
                if (err) {
                  return console.log(err);
                }
                var result = data
                var hasNamespace = result.includes("namespace rodash.")

                if (hasNamespace) {
                  namespace = result.match(/.*namespace.*\n /g)[0].trim().replace("namespace rodash.", '');
                  if (outputs[namespace] === undefined) {
                    outputs[namespace] = "";
                  }

                  result = result.replace(/^.*namespace.*$/gm, '');
                  outputs[namespace] += result + "\n\n"

                } else {
                  result = result.replace(/^.*namespace.*$/gm, '');
                  outputs["rodash"] += result + "\n\n"
                }

              });
            }
          });

          setTimeout(function() {
            for (let [key, value] of Object.entries(outputs)) {
              value = value.replace(/^\s+/mg,'');
              if (key == "rodash") {
                output += value + "\n"
              } else {
                output += "namespace " + key + "\n";
                output += value + "\n";
                output += "end namespace" + "\n";
              }
            }

            fs.writeFile(outputDirectory + 'rodash.d.bs', output, 'utf8', function (err) {
              if (err) return console.log(err);
                console.log("rodash.d.bs created")
            });
          }, 250);
        })
      });
    })
  });
})
