# rodash (BETA)
[Lodash](https://lodash.com/docs/4.17.15) inspired [Brightscript](https://developer.roku.com/en-ca/docs/references/brightscript/language/brightscript-language-reference.md)/[ROPM](https://www.npmjs.com/package/ropm) utility for Roku apps

Currently supporting 150 utility functions!
API Documentation coming soon.


## Installation
### Using [ropm](https://www.npmjs.com/package/ropm)
```bash
ropm install rodash@npm:@tkss/rodash
```

## Usage Examples
### Chunk
#### Brightscript
```
rodash_chunk(["a", "b", "c", "d"], 2)
```
#### Brighterscript
```
rodash.chunk(["a", "b", "c", "d"], 2)
```
Returns: [["a", "b"], ["c", "d"]]


### Compact
#### Brightscript
```
rodash_compact([0, 1, false, 2, "", 3])
```
#### Brighterscript
```
rodash.compact([0, 1, false, 2, "", 3])
```
Returns: [1, 2, 3]


### Shuffle & Slice
#### Brightscript
```
rodash_slice(rodash_shuffle([1,2,3,4,5,6,7,8,9,10]), 0, 4)
```

#### Brighterscript
```
rodash.slice(rodash.shuffle([1,2,3,4,5,6,7,8,9,10]), 0, 4)
```
Returns: [8, 3, 7, 5]
## Brighterscript Support
If imported into a project that leverages the Brighterscript compiler, you can use rodash. lookups with auto-complete.
![image](https://user-images.githubusercontent.com/2446955/110862815-30c73900-8296-11eb-8533-4ec1011d7fba.png)


## Development

Currently in development
