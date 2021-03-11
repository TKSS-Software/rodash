# rodash (BETA)
[Lodash](https://lodash.com/docs/4.17.15) inspired [Brightscript](https://developer.roku.com/en-ca/docs/references/brightscript/language/brightscript-language-reference.md)/[ROPM](https://www.npmjs.com/package/ropm) ulitity for Roku apps

Currently supporting 150 ulitity functions! API Documentation coming soon.


## Installation
### Using [ropm](https://www.npmjs.com/package/ropm)
```bash
ropm install rodash@npm:@tkss/rodash
```

## Usage Examples
### Chunk
```
rodash.chunk(["a", "b", "c", "d"], 2)
```
Returns: ["a", "b"], ["c", "d"]]

### Compact
```
rodash.compact([0, 1, false, 2, "", 3])
```
Returns: [1, 2, 3]

### Shuffle & Slice
```
rodash.slice(rodash.shuffle([1,2,3,4,5,6,7,8,9,10]), 0, 4)
```
Returns: [8, 3, 7, 5, 1]

## Development

Currently in development
