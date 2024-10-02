# rodash
[Lodash](https://lodash.com/docs/4.17.15) inspired [Brightscript](https://developer.roku.com/en-ca/docs/references/brightscript/language/brightscript-language-reference.md)/[ROPM](https://www.npmjs.com/package/ropm) utility for Roku apps. Currently supporting over 200 utility functions!


[![build status](https://img.shields.io/github/workflow/status/TKSS-Software/rodash/build.yml?logo=github&branch=master)](https://github.com/TKSS-Software/rodash/actions?query=branch%3Amaster+workflow%3Abuild)
[![monthly downloads](https://img.shields.io/npm/dm/@tkss/rodash.svg?sanitize=true&logo=npm&logoColor=)](https://npmcharts.com/compare/@tkss/rodash?minimal=true)
[![npm version](https://img.shields.io/npm/v/@tkss/rodash.svg?logo=npm)](https://www.npmjs.com/package/@tkss/rodash)
[![license](https://img.shields.io/github/license/TKSS-Software/rodash.svg)](LICENSE)
[![Slack](https://img.shields.io/badge/Slack-RokuCommunity-4A154B?logo=slack)](https://join.slack.com/t/rokudevelopers/shared_invite/zt-4vw7rg6v-NH46oY7hTktpRIBM_zGvwA)



## Important
This project is not affiliated with the Tubitv/rodash project.

## Installation
### Using [ropm](https://www.npmjs.com/package/ropm)
```bash
ropm install rodash@npm:@tkss/rodash
```

## API Documentation (In Progress)
[https://tkss-software.github.io/rodash/index.html](https://tkss-software.github.io/rodash/index.html)

## Usage Examples
### Chunk
#### Brightscript
```brightscript
rodash_chunk(["a", "b", "c", "d"], 2)
```
#### Brighterscript
```brighterscript
rodash.chunk(["a", "b", "c", "d"], 2)
```
Returns: `[["a", "b"], ["c", "d"]]`


### Compact
#### Brightscript
```brightscript
rodash_compact([0, 1, false, 2, "", 3])
```
#### Brighterscript
```brighterscript
rodash.compact([0, 1, false, 2, "", 3])
```
Returns: `[1, 2, 3]`


### Shuffle & Slice
#### Brightscript
```brightscript
rodash_slice(rodash_shuffle([1,2,3,4,5,6,7,8,9,10]), 0, 4)
```

#### Brighterscript
```brighterscript
rodash.slice(rodash.shuffle([1,2,3,4,5,6,7,8,9,10]), 0, 4)
```
Returns: `[8, 3, 7, 5]`
## Brighterscript Support
If imported into a project that leverages the Brighterscript compiler, you can use rodash. lookups with auto-complete.
![image](https://user-images.githubusercontent.com/2446955/110862815-30c73900-8296-11eb-8533-4ec1011d7fba.png)


## Development

Currently in development
