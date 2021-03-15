

' /**
' * Adds two numbers.
' * @category Math
' * @param {Dynamic} augend - The first number in an addition
' * @param {Dynamic} addend - The second number in an addition
' * @returns {Dynamic} value - Returns the total
' */
function add(augend, addend)
    value = 0
    if isNumber(augend) then
        value += augend
    end if
    if isNumber(addend) then
        value += addend
    end if
    return value
end function 

' /**
' * Returns a formatted version of the current time/date.
' * @category Date
' * @param {String} format - The date format
' * @returns {Object} value - Returns a object containing the formatted date for both UTC and Local time
' */
function asDateString(format = "long-date" as string) as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.asDateString(format),
        "local": dateObj.local.asDateString(format)
    }
end function 

' /**
' * Returns the current time in seconds.
' * @category Date
' * @returns {Object} value - Returns a object containing the date/time in seconds for both UTC and Local time
' */
function asSeconds() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.asSeconds(),
        "local": dateObj.local.asSeconds()
    }
end function 

' /**
' * Assigns own enumerable string keyed properties of source objects to the destination object. Source objects are applied from left to right. Subsequent sources overwrite property assignments of previous sources.
' * This method mutates object and is loosely based on Object.assign.
' * @param {Dynamic} baseAA - The destination object
' * @params {Object} sources - The source objects
' * @params {Dynamic} Mutaded baseAA
' */
function assign(baseAA as dynamic, sources = [] as object) as dynamic
    if NOT isAA(baseAA) then
        return Invalid
    end if
    for each source in sources
        if isAA(source) then
            baseAA.append(source)
        end if
    end for
    return baseAA
end function 

' /**
' * Creates an array of values corresponding to paths of object.
' * @category Object
' * @param {AssocArray} obj - The object to iterate over.
' * @param {Array} paths - The property paths to pick.
' * @returns {Array} value - Returns the picked values.
' */
function at(obj = {} as object, paths = [] as object)
    returnArray = []
    for each path in paths
        result = get(obj, path)
        returnArray.push(result)
    end for
    return returnArray
end function 

function camelCase(value = "" as string)
    value = value.replace("-", " ").replace("_", " ")
    value = value.trim()
    valueArray = value.split(" ")
    responseValue = ""
    for i = 0 to valueArray.count() - 1
        valueString = valueArray[i]
        if i = 0 then
            responseValue += lcase(valueString)
        else
            responseValue += capitalize(valueString)
        end if
    end for
    return responseValue
end function 

function capitalize(value = "" as string)
    value = value.trim()
    valueArray = value.split("")
    responseValue = ""
    for i = 0 to valueArray.count() - 1
        valueString = valueArray[i]
        if i = 0 then
            responseValue += ucase(valueString)
        else
            responseValue += lcase(valueString)
        end if
    end for
    return responseValue
end function 

' /**
' * Computes number rounded up to precision.
' * @param {Integer} number - The number to round up
' * @param {Integer} precision - The precision to round up to
' * @returns {Integer} Returns the rounded up number
' */
function ceil(number = 0, precision = 0 as integer)
    return - int(- number * 10 ^ precision) / 10 ^ precision
end function 

' /**
' * Creates an array of elements split into groups the length of size. If array can't be split evenly, the final chunk will be the remaining elements.
' * @param {Array} array - The array to process
' * @param {Integer} chunkSize - The length of each chunk
' * @returns {Array} returnArray - Returns the new array of chunks
' */
function chunk(array = [] as object, chunkSize = 1 as integer) as object
    array = clone(array)
    numberOfChunks = floor(array.count() / chunkSize)
    returnArray = CreateObject("roArray", numberOfChunks, true)
    arrayIndex = 0
    for index = 0 to numberOfChunks
        chunkArray = []
        for i = 0 to chunkSize - 1
            chunkArray.push(array[arrayIndex])
            arrayIndex++
            if arrayIndex = array.count() then
                exit for
            end if
        end for
        returnArray[index] = chunkArray
        if arrayIndex = array.count() then
            exit for
        end if
    end for
    return returnArray
end function 

function clamp(number, lower, upper) as dynamic
    return max([
        lower,
        min([
            upper,
            number
        ])
    ])
end function 

' /**
' * Clones objects that can be cloned.
' * @param {Dynamic} value - The value to be cloned
' * @returns {Dynamic} clonedValue - The cloned value
' */
function clone(value = invalid as dynamic) as dynamic
    if isInvalid(value) then
        return invalid
    end if
    clonedValue = invalid
    if isString(value) then
        clonedValue = "" + value
    else if isAA(value) then
        clonedValue = CreateObject("roAssociativeArray")
        clonedValue.append(value)
    else if isArray(value) then
        clonedValue = CreateObject("roArray", value.count(), true)
        clonedValue.append(value)
    else if isNumber(value) then
        clonedValue = 0 + value
    else if isBoolean(value) then
        clonedValue = false OR value
    else if isNode(value) then
        clonedValue = value.clone(true)
    end if
    return clonedValue
end function 

' /**
' * Creates an array with all falsey values removed. The values false, 0, "", and invalid are falsey.
' * @param {Array} array - The array to compact
' * @returns {Array} returnArray - Returns the new array of filtered values
' */
function compact(array = [] as object) as object
    returnArray = []
    for each item in array
        shallPass = true
        typeName = type(item)
        if isInvalid(item) then
            shallPass = false
        else if isEmptyString(item) then
            shallPass = false
        else if isNumber(item) then
            if item = 0 then
                shallPass = false
            end if
        else if isBoolean(item) then
            shallPass = item
        end if
        if shallPass then
            returnArray.push(item)
        end if
    end for
    return returnArray
end function 

' /**
' * Creates a new array concatenating array with any additional arrays and/or values.
' * @param {Array} array - The array to concatenate
' * @param {Array} values - The values to concatenate
' * @returns {Array} returnArray - Returns the new concatenated array
' */
function concat(array = [] as object, values = [] as object) as object
    returnArray = []
    returnArray.append(array)
    for each value in values
        if isArray(value) then
            returnArray.append(value)
        else
            returnArray.push(value)
        end if
    end for
    return returnArray
end function 

' /**
' * Creates an array of array values not included in the other given arrays using SameValueZero for equality comparisons. The order and references of result values are determined by the first array.
' * @param {Array} array - The array to inspect
' * @param {Array} values - The values to exclude
' * @returns {Array} difference - Returns the new array of filtered values
' */
function difference(array = [] as object, values = [] as object) as object
    return differenceBy(array, values)
end function 

' /**
' * This method is like rodash.difference except that it accepts iteratee which is invoked for each element of array and values to generate the criterion by which they're compared. The order and references of result values are determined by the first array. The iteratee is invoked with one argument:(value).
' * @param {Array} array - The array to inspect
' * @param {Array} values - The values to exclude
' * @param {Dynamic} iteratee - The iteratee invoked per element
' * @returns {Array} returnArray - Returns the new array of filtered values
' */
function differenceBy(array = [] as object, values = [] as object, iteratee = invalid) as object
    iterateeIsFunction = isFunction(iteratee)
    iterateeIsProperty = NOT iterateeIsFunction AND isString(iteratee)
    returnArray = []
    for each item in array
        convertedItem = item
        if iterateeIsFunction then
            convertedItem = iteratee(item)
        else if iterateeIsProperty then
            convertedItem = item[iteratee]
        end if
        found = false
        for each valueToMatch in values
            if iterateeIsFunction then
                valueToMatch = iteratee(valueToMatch)
            else if iterateeIsProperty then
                valueToMatch = valueToMatch[iteratee]
            end if
            if convertedItem = valueToMatch then
                found = true
                exit for
            end if
        end for
        if NOT found then
            returnArray.push(item)
        end if
    end for
    return returnArray
end function 

' /**
' * This method is like rodash.difference except that it accepts comparator which is invoked to compare elements of array to values. The order and references of result values are determined by the first array. The comparator is invoked with two arguments: (arrVal, othVal).
' * @param {Array} array - The array to inspect
' * @param {Array} values - The values to exclude
' * @param {Dynamic} iteratee - The iteratee invoked per element
' * @returns {Array} returnArray - Returns the new array of filtered values
' */
function differenceWith(array = [] as object, values = [] as object, comparator = invalid) as object
    returnArray = []
    if isFunction(comparator) then
        for i = 0 to array.count() - 1
            itemOne = array[0]
            itemTwo = array[1]
            if isNotInvalid(itemOne) AND isNotInvalid(itemTwo) AND NOT isEqual(itemOne, itemTwo) then
                returnArray.push(itemOne)
            end if
        end for
    end if
    return returnArray
end function 

' /**
' * Divides two numbers
' * @param {Dynamic} dividend - The first number in a division
' * @param {Dynamic} divisor - The second number in a division
' * @returns {Integer} value - Returns the quotient
' */
function divide(dividend = 0 as dynamic, divisor = 0 as dynamic) as dynamic
    if isNaN(dividend) OR isNaN(divisor) then
        return 0
    end if
    if lte(divisor, 0) then
        return dividend
    end if
    return dividend / divisor
end function 

' /**
' * Creates a slice of array with n elements dropped from the beginning.
' * @param {Array} array - The array to query
' * @param {Integer} n - The number of elements to drop
' * @returns {Array} array - Returns the slice of array
' */
function drop(array = {} as object, n = 1 as integer)
    array = clone(array)
    for i = 0 to n - 1
        array.shift()
        if array.count() = 0 then
            exit for
        end if
    end for
    return array
end function 

' /**
' * Creates a slice of array with n elements dropped from the end.
' * @param {Array} array - The array to query
' * @param {Integer} n - The number of elements to drop
' * @returns {Array} array - Returns the slice of array
' */
function dropRight(array = {} as object, n = 1 as integer)
    array = clone(array)
    array.reverse()
    array = drop(array, n)
    array.reverse()
    return array
end function 

' /**
' * Creates a slice of array excluding elements dropped from the end. Elements are dropped until predicate returns falsey. The predicate is invoked with three arguments: (value, index, array).
' * @param {Array} array - The array to query
' * @param {Dynamic} predicate - The function invoked per iteration
' * @returns {Array} array - Returns the slice of array
' */
function dropRightWhile(array = {} as object, predicate = invalid)
    array = clone(array)
    array.reverse()
    array = dropWhile(array, predicate)
    array.reverse()
    return array
end function 

'/**
' * Creates a slice of array excluding elements dropped from the beginning. Elements are dropped until predicate returns falsey. The predicate is invoked with three arguments: (value, index, array).
' * @param {Array} array - The array to query
' * @param {Dynamic} predicate - The function invoked per iteration
' * @return {Array} array - Returns the slice of array
' */
function dropWhile(array = [] as object, predicate = invalid)
    array = clone(array)
    for i = 0 to array.count() - 1
        item = array[i]
        if isFunction(predicate) then
            if NOT predicate(item) then
                return slice(array, i)
            end if
        else if isAA(predicate) then
            if NOT isEqual(item, predicate) then
                return slice(array, i)
            end if
        else if isArray(predicate) then
            if NOT isEqual(item[predicate[0]], predicate[1]) then
                return slice(array, i)
            end if
        else if isString(predicate) then
            if NOT item[predicate] then
                return slice(array, i)
            end if
        end if
    end for
    return array
end function 

function endsWith(source = "" as string, target = "" as string, position = invalid as dynamic)
    if isInvalid(position) then
        position = source.len()
    end if
    return source.endsWith(target, position)
end function 

function eq(value as dynamic, other as dynamic)
    return isEqual(value, other)
end function 

function escape(source = "" as string)
    return source.escape()
end function 

function escapeRegExp(source = "" as string)
    replaceArray = [
        "^",
        "$",
        "",
        ".",
        "*",
        "+",
        "?",
        "(",
        ")",
        "[",
        "]",
        "{",
        "}",
        "|"
    ]
    for each char in replaceArray
        source = source.replace(char, "\" + char)
    end for
    return source.replace("\/\/", "//")
end function 

'/**
' * Fills elements of array with value from start up to, but not including, end.
' * This method mutates array.
' * @param {Array} array - The array to fill
' * @param {Dynamic} value - The value to fill array with
' * @param {Integer} startPos - The start position
' * @param {Integer} endPos - The end position
' * @returns {Array} array - Returns the mutated array
' */
function fill(array = [] as object, value = "" as dynamic, startPos = invalid, endPos = invalid)
    if isInvalid(startPos) then
        startPos = 0
    end if
    if isInvalid(endPos) then
        endPos = array.count()
    end if
    endPos = endPos - 1
    for i = startPos to endPos
        array[i] = value
    end for
    return array
end function 

'/**
' * This method is like rodash.find except that it returns the index of the first element predicate returns truthy for instead of the element itself.
' * @param {Array} array - The array to inspect
' * @param {Dynamic} predicate - The function invoked per iteration
' * @param {Integer} fromIndex - The index to search from
' * @returns {Integer} index - Returns the index of the found element, else -1
' */
function findIndex(array, predicate = invalid as dynamic, fromIndex = 0 as integer) as integer
    for index = fromIndex to array.count() - 1
        item = array[index]
        if isFunction(predicate) then
            if predicate(item) then
                return index
            end if
        else if isAA(predicate) then
            if isEqual(item, predicate) then
                return index
            end if
        else if isArray(predicate) then
            if isEqual(item[predicate[0]], predicate[1]) then
                return index
            end if
        else if isString(predicate) then
            if item[predicate] then
                return index
            end if
        end if
    end for
    return - 1
end function 

'/**
' * This method is like rodash.findIndex except that it iterates over elements of collection from right to left.
' * @param {Array} array - The array to inspect
' * @param {Dynamic} predicate - The function invoked per iteration
' * @param {Integer} fromIndex - The index to search from
' * @returns {Integer} index - Returns the index of the found element, else -1
' */
function findLastIndex(array, predicate = invalid, fromIndex = 0 as integer)
    array = clone(array)
    array.reverse()
    foundIndex = findIndex(array, predicate, fromIndex)
    if foundIndex = - 1 then
        return - 1
    end if
    return array.count() - 1 - foundIndex
end function 

'/**
' * An alias to the head function.
' * @param {Array} array - The array to query
' * @return {Dynamic} Returns the first element of array
' */
function first(array = [])
    return head(array)
end function 

'/**
' * Flattens array a single level deep.
' * @param {Array} array - The array to flatten
' * @returns {Dynamic} Returns the new flattened array
' */
function flatten(array = [])
    returnArray = []
    for each item in array
        if type(item) = "roArray" then
            returnArray.append(item)
        else
            returnArray.push(item)
        end if
    end for
    return returnArray
end function 

'/**
' * Recursively flattens array.
' * @param {Array} array - The array to flatten
' * @returns {Dynamic} Returns the new flattened array
' */
function flattenDeep(array = [])
    returnArray = []
    for each item in array
        if type(item) = "roArray" then
            returnArray.append(flattenDeep(item))
        else
            returnArray.push(item)
        end if
    end for
    return returnArray
end function 

'/**
' * Recursively flatten array up to depth times.
' * @param {Array} array - The array to flatten
' * @param {Integer} depth - The maximum recursion depth
' * @return {Dynamic} Returns the new flattened array
' */
function flattenDepth(array = invalid, depth = 1 as integer)
    returnArray = []
    if NOT isArray(array) then
        return array
    end if
    for i = 0 to array.count() - 1
        item = array[i]
        if (depth > 1) then
            item = flattenDepth(item, depth - 1)
            if isArray(item) then
                returnArray.append(item)
            else
                returnArray.push(item)
            end if
        else
            if isArray(item) then
                returnArray.append(item)
            else
                returnArray.push(item)
            end if
        end if
    end for
    return returnArray
end function 

' /**

' * Computes number rounded down to precision
' * @param {Integer} number - The number to round down
' * @param {Integer} precision - The precision to round down to
' * @return {Integer} Returns the rounded down number
' */
function floor(number = 0, precision = 0 as integer)
    return int(number * 10 ^ precision) / 10 ^ precision
end function 

' /**

' * Iterates over elements of collection and invokes iteratee for each element. The iteratee is invoked with three arguments: (value, index|key, collection). Iteratee functions may exit iteration early by explicitly returning false.
' * Note: As with other "Collections" methods, objects with a "length" property are iterated like arrays. To avoid this behavior use rodash.forIn or rodash.forOwn for object iteration.
' * @param {Dynamic} collection - The collection to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Dynamic} Returns collection
' */
function forEach(collection = invalid as dynamic, iteratee = invalid as dynamic)
    return internal_baseForEach(collection, iteratee)
end function 

' /**

' * This method is like rodash.forEach except that it iterates over elements of collection from right to left.
' * @param {Dynamic} collection - The collection to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Dynamic} Returns collection
' */
function forEachRight(collection = invalid as dynamic, iteratee = invalid as dynamic)
    return internal_baseForEach(collection, iteratee, "right")
end function 

' /**

' * Iterates over own and inherited enumerable string keyed properties of an object and invokes iteratee for each property. The iteratee is invoked with three arguments: (value, key, object). Iteratee functions may exit iteration early by explicitly returning false.
' * @param {Dynamic} obj - The object to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Object} Returns object
' */
function forIn(obj = {} as object, iteratee = invalid as dynamic)
    return internal_baseForEach(obj, iteratee, "left", "omit")
end function 

' /**

' * This method is like rodash.forIn except that it iterates over properties of object in the opposite order.
' * @param {Dynamic} obj - The object to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Object} Returns object
' */
function forInRight(obj = {} as object, iteratee = invalid as dynamic)
    return internal_baseForEach(obj, iteratee, "right", "omit")
end function 

' /**

' * Iterates over own enumerable string keyed properties of an object and invokes iteratee for each property. The iteratee is invoked with three arguments: (value, key, object). Iteratee functions may exit iteration early by explicitly returning false.
' * @param {Dynamic} obj - The object to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Object} Returns object
' */
function forOwn(obj = {} as object, iteratee = invalid as dynamic)
    return internal_baseForEach(obj, iteratee, "left", "omit")
end function 

' /**

' * This method is like rodash.forOwn except that it iterates over properties of object in the opposite order.
' * @param {Dynamic} obj - The object to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Object} Returns object
' */
function forOwnRight(obj = {} as object, iteratee = invalid as dynamic)
    return internal_baseForEach(obj, iteratee, "right", "omit")
end function 

function fromISO8601String(dateString = "" as string) as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.fromISO8601String(dateString),
        "local": dateObj.local.fromISO8601String(dateString)
    }
end function 

function fromSeconds(numSeconds = 0 as integer) as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.fromSeconds(numSeconds),
        "local": dateObj.local.fromSeconds(numSeconds)
    }
end function 

' TODO: Rewrite this due to scoping issue
' /**

' * Creates an array of function property names from own enumerable properties of object.
' * @param {Dynamic} obj - The object to iterate over
' * @return {Object} Returns object
' */
function functions(obj = {} as object)
    ' return rodash.base.forEach.baseForEach(obj, invalid, "left", "only")
    return []
end function 

' TODO: Rewrite this due to scoping issue
' /**

' * Creates an array of function property names from own and inherited enumerable properties of object.
' * @param {Dynamic} obj - The object to iterate over
' * @return {Object} Returns object
' */
function functionsIn(obj = {} as object)
    ' return rodash.base.forEach.baseForEach(obj, invalid, "left", "only")
    return []
end function 

' /**

' * Gets the value at path of object. If the resolved value is undefined, the defaultValue is returned in its place.
' * @param {Object} aa - Object to drill down into.
' * @param {String} keyPath - A dot notation based string to the expected value.
' * @param {Dynamic} fallback - A return fallback value if the requested field could not be found or did not pass the validator function.
' * @param {Function} validator - A function used to validate the output value matches what you expected.
' * @return {Dynamic} The result of the drill down process
' */
function get(aa as object, keyPath as string, fallback = Invalid as dynamic, validator = isNotInvalid as Function) as dynamic
    if NOT (internal_isKeyedValueType(aa) OR isNonEmptyArray(aa)) OR keyPath = "" then
        return fallback
    end if
    nextValue = aa
    keyPath = internal_sanitizeKeyPath(keyPath)
    keys = keyPath.tokenize(".").toArray()
    startingKeys = join(keys, " - ")
    for each key in keys
        if internal_isKeyedValueType(nextValue) then
            nextValue = nextValue[key]
        else if isNonEmptyArray(nextValue) then
            nextValue = nextValue[toNumber(key)]
        else
            return fallback
        end if
    end for
    if NOT validator(nextValue) then
        return fallback
    end if
    return nextValue
end function 

function getDayOfMonth() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getDayOfMonth(),
        "local": dateObj.local.getDayOfMonth()
    }
end function 

function getDayOfWeek() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getDayOfWeek(),
        "local": dateObj.local.getDayOfWeek()
    }
end function 

function getHours() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getHours(),
        "local": dateObj.local.getHours()
    }
end function 

function getLastDayOfMonth() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getLastDayOfMonth(),
        "local": dateObj.local.getLastDayOfMonth()
    }
end function 

function getMilliseconds() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getMilliseconds(),
        "local": dateObj.local.getMilliseconds()
    }
end function 

function getMinutes() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getMinutes(),
        "local": dateObj.local.getMinutes()
    }
end function 

function getMonth() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getMonth(),
        "local": dateObj.local.getMonth()
    }
end function 

function getSeconds() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getSeconds(),
        "local": dateObj.local.getSeconds()
    }
end function 

function getYear() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.getYear(),
        "local": dateObj.local.getYear()
    }
end function 

function gt(value as dynamic, other as dynamic)
    return value > other
end function 

function gte(value as dynamic, other as dynamic)
    return value >= other
end function 

' /**

' * Checks if first level of the supplied AssociativeArray contains the Array of key strings.
' * @param {Dynamic} aaValue - AssociativeArray to be checked
' * @return {Dynamic} keys - Array of key strings
' */
function hasKeys(aaValue as dynamic, keys as dynamic) as boolean
    if NOT isKeyedValueType(aaValue) OR aaValue.isEmpty() OR NOT isArray(keys) OR keys.isEmpty() then
        return false
    end if
    hasKeys = true
    for each key in keys
        if NOT aaValue.doesExist(key) then
            hasKeys = false
            exit for
        end if
    end for
    return hasKeys
end function 

'/**

' * Gets the first element of array.
' * @param {Array} array - The array to query
' * @return {Dynamic} Returns the first element of array
' */
function head(array = [] as object) as dynamic
    return array[0]
end function 

'/**

' * Gets the index at which the first occurrence of value is found in array using SameValueZero for equality comparisons. If fromIndex is negative, it's used as the offset from the end of array.
' * @param {Array} array - The array to inspect
' * @param {Dynamic} value - The value to search for
' * @param {Integer} fromIndex - The index to search from
' * @return {Integer} Returns the index of the matched value, else -1
' */
function indexOf(array = [] as object, value = invalid, fromIndex = invalid)
    if NOT isArray(array) then
        return - 1
    end if
    if isInvalid(fromIndex) then
        fromIndex = 0
    end if
    for index = fromIndex to array.count() - 1
        item = array[index]
        if isEqual(item, value) then
            return index
        end if
    end for
    return - 1
end function 

'/**

' * Gets all but the last element of array.
' * @param {Array} array - The array to query
' * @return {Array} Returns the slice of array
' */
function initial(array = [] as object)
    if NOT isArray(array) then
        return []
    end if
    return slice(array, 0, array.count() - 1)
end function 

function inRange(number as dynamic, startPos = 0 as dynamic, endPos = invalid as dynamic)
    if (isInvalid(endPos)) then
        endPos = startPos
        startPos = 0
    end if
    if gt(startPos, endPos) then
        startPosTemp = startPos
        endPosTemp = endPos
        startPos = endPosTemp
        endPos = startPosTemp
    end if
    return gte(number, startPos) AND lt(number, endPos)
end function 

' /**

' * @ignore
' * Attempts to convert the supplied value to a string.
' * @param {Dynamic} value - The value to convert.
' * @return {String} - Results of the conversion.
' */
function internal_aaToString(aa as object) as string
    description = "{"
    for each key in aa
        description += key + ": " + toString(aa[key]) + ", "
    end for
    description = description.left(description.len() - 2) + "}"
    return description
end function 

' /**

' * @ignore
' * Attempts to convert the supplied value to a string.
' * @param {Dynamic} value The value to convert.
' * @return {String} Results of the conversion.
' */
function internal_arrayToString(array as object) as string
    description = "["
    for each item in array
        description += toString(item) + ", "
    end for
    description = description.left(description.len() - 2) + "]"
    return description
end function 

' /**

' * @ignore
' * The base implementation of `forEach`.
' * @param {Array|Object} - collection The collection to iterate over
' * @param {Function} iteratee The function invoked per iteration
' * @param {String} direction - the direction to traverse the collection
' * @param {String} funcValueRule - Filters functions from collection. `allow`, `omit`, `only`.
' * @return {Array|Object} Returns `collection`
' */
function internal_baseForEach(collection = invalid as dynamic, iteratee = invalid as dynamic, direction = "left", funcValueRule = "allow" as string)
    if isInvalid(collection) OR isEmpty(collection) then
        return invalid
    end if
    isRight = direction = "right"
    if isAA(collection) then
        keys = collection.keys()
        if isRight then
            keys.reverse()
        end if
        for each key in keys
            item = collection[key]
            if isFunction(iteratee) then
                valueIsFunction = isFunction(item)
                allowValue = false
                if valueIsFunction AND NOT isEqual(funcValueRule, "omit") then
                    allowValue = true
                else if NOT valueIsFunction AND NOT isEqual(funcValueRule, "only") then
                    allowValue = true
                end if
                if allowValue then
                    iteratee(item, key)
                end if
            end if
        end for
    else
        if isRight then
            collection.reverse()
        end if
        for each item in collection
            if isFunction(iteratee) then
                iteratee(item)
            end if
        end for
        if isRight then
            collection.reverse()
        end if
    end if
    return collection
end function 

' /**

' * @ignore
' * Attempts to convert the supplied value to a string.
' * @param {Dynamic} value The value to convert.
' * @return {String} Results of the conversion.
' */
function internal_booleanToString(bool as boolean) as string
    if bool then
        return "true"
    end if
    return "false"
end function 

' /**

' * @ignore
' * Checks if the supplied values can be compared in a if statement.
' * @param {Dynamic} valueOne - First value
' * @param {Dynamic} valueTwo - Second value
' * @return {Boolean} True if the values can be compared in a if statement
' */
function internal_canBeCompared(valueOne as dynamic, valueTwo as dynamic) as boolean
    ' If the first argument is true we don't need to check the following conditionals
    if isString(valueOne) then
        if isString(valueTwo) then
            return true
        end if
    else if isNumber(valueOne) then
        if isNumber(valueTwo) then
            return true
        end if
    else if isBoolean(valueOne) then
        if isBoolean(valueTwo) then
            return true
        end if
    else if isInvalid(valueOne) then
        if isInvalid(valueTwo) then
            return true
        end if
    end if
    return false
end function 

' * @ignore
function internal_getConstants()
    return {
        BrightScriptErrorCodes: {
            ' runtime errors
            ERR_OKAY: &hFF,
            ERR_NORMAL_END: &hFC, ' normal, but terminate execution.  END, shell "exit", window closed, etc.
            ERR_VALUE_RETURN: &hE2, ' return executed, and a value returned on the stack
            ERR_INTERNAL: &hFE, ' A condition that shouldn't occur did
            ERR_UNDEFINED_OPCD: &hFD, ' A opcode that we don't handle
            ERR_UNDEFINED_OP: &hFB, ' An expression operator that we don't handle
            ERR_MISSING_PARN: &hFA,
            ERR_STACK_UNDER: &hF9, ' nothing on stack to pop
            ERR_BREAK: &hF8, ' scriptBreak() called
            ERR_STOP: &hF7, ' stop statement executed
            ERR_RO0: &hF6, ' bscNewComponent failed because object class not found
            ERR_RO1: &hF5, ' ro function call does not have the right number of parameters
            ERR_RO2: &hF4, ' member function not found in object or interface
            ERR_RO3: &hF3, ' Interface not a member of object
            ERR_TOO_MANY_PARAM: &hF2, ' Too many function parameters to handle
            ERR_WRONG_NUM_PARAM: &hF1, ' Incorect number of function parameters
            ERR_RVIG: &hF0, ' Function returns a value, but is ignored
            ERR_NOTPRINTABLE: &hEF, ' Non Printable value
            ERR_NOTWAITABLE: &hEE, ' Tried to Wait on a function that does not have MessagePort interface
            ERR_MUST_BE_STATIC: &hED, ' interface calls from type rotINTERFACE must by static
            ERR_RO4: &hEC, ' . operator used on a variable that does not contain a legal object or interface reference
            ERR_NOTYPEOP: &hEB, ' operation on two typless operands attempted
            ERR_USE_OF_UNINIT_VAR: &hE9, ' illegal use of uninited var
            ERR_TM2: &hE8, ' non-numeric index to array
            ERR_ARRAYNOTDIMMED: &hE7,
            ERR_USE_OF_UNINIT_BRSUBREF: &hE6, ' used a reference to SUB that is not initilized
            ERR_MUST_HAVE_RETURN: &hE5,
            ERR_INVALID_LVALUE: &hE4, ' invalid left side of expression
            ERR_INVALID_NUM_ARRAY_IDX: &hE3, ' invalid number of array indexes
            ERR_UNICODE_NOT_SUPPORTED: &hE1,
            ERR_NOTFUNOPABLE: &hE0,
            ERR_STACK_OVERFLOW: &hDF,
            ERR_THROWN_EXCEPTION_ON_STACK: &hDE, '(Internal use only)
            ERR_SYNTAX: &h02,
            ERR_DIV_ZERO: &h14,
            ERR_MISSING_LN: &h0E,
            ERR_OUTOFMEM: &h0C,
            ERR_STRINGTOLONG: &h1C,
            ERR_TM: &h18, ' Type Mismatch (string / numeric operation mismatch)
            ERR_OS: &h1A, ' out of string space
            ERR_RG: &h04, ' Return without Gosub
            ERR_NF: &h00, ' Next without For
            ERR_FC: &h08, ' Invalid parameter passed to function/array (e.g neg matrix dim or squr root)
            ERR_DD: &h12, ' Attempted to redimension an array
            ERR_BS: &h10, ' Array subscript out of bounds
            ERR_OD: &h06, ' Out of Data (READ)
            ERR_CN: &h20, ' Continue Not Allowed
            ERR_BITSHIFT_BAD: &h1E, ' Invalid Bitwise Shift
            ERR_EXECUTION_TIMEOUT: &h23, ' Timeout on critical thread
            ERR_CONSTANT_OVERFLOW: &h22, ' Constant Out Of Range
            ERR_FORMAT_SPECIFIER: &h24, ' Invalid Format Specifier
            ERR_BAD_THROW: &h26, ' Invalid argument to Throw
            ERR_USER: &h28, ' User-specified exception
            ' compiler errors
            ERR_NW: &hBF, ' EndWhile with no While
            ERR_MISSING_ENDWHILE: &hBE, ' While Statement is missing a matching EndWhile
            ERR_MISSING_ENDIF: &hBC, ' end of code reached without finding ENDIF
            ERR_NOLN: &hBB, ' no line number found
            ERR_LNSEQ: &hBA, ' Line number sequence error
            ERR_LOADFILE: &hB9, ' Error loading a file
            ERR_NOMATCH: &hB8, ' "Match" statement did not match
            ERR_UNEXPECTED_EOF: &hB7, ' End of string being compiled encountered when not expected (missing end of block usually)
            ERR_FOR_NEXT_MISMATCH: &hB6, ' Variable on a NEXT does not match that for the FOR
            ERR_NO_BLOCK_END: &hB5,
            ERR_LABELTWICE: &hB4, ' Label defined more than once
            ERR_UNTERMED_STRING: &hB3, ' litteral string does not have ending quote
            ERR_FUN_NOT_EXPECTED: &hB2,
            ERR_TOO_MANY_CONST: &hB1,
            ERR_TOO_MANY_VAR: &hB0,
            ERR_EXIT_WHILE_NOT_IN_WHILE: &hAF,
            ERR_INTERNAL_LIMIT_EXCEDED: &hAE,
            ERR_SUB_DEFINED_TWICE: &hAD,
            ERR_NOMAIN: &hAC,
            ERR_FOREACH_INDEX_TM: &hAB,
            ERR_RET_CANNOT_HAVE_VALUE: &hAA,
            ERR_RET_MUST_HAVE_VALUE: &hA9,
            ERR_FUN_MUST_HAVE_RET_TYPE: &hA8,
            ERR_INVALID_TYPE: &hA7,
            ERR_NOLONGER: &hA6, ' no longer supported
            ERR_EXIT_FOR_NOT_IN_FOR: &hA5,
            ERR_MISSING_INITILIZER: &hA4,
            ERR_IF_TOO_LARGE: &hA3,
            ERR_RO_NOT_FOUND: &hA2,
            ERR_TOO_MANY_LABELS: &hA1,
            ERR_VAR_CANNOT_BE_SUBNAME: &hA0,
            ERR_INVALID_CONST_NAME: &h9F,
            ERR_CONST_FOLDING: &h9E,
            ERR_BUILTIN_FUNCTION: &h9D,
            ERR_FUNCTION_NOT_IN_NAMESPACE: &h91,
            ERR_EVAL_UNSUPPORTED: &h90,
            ERR_LABEL_INSIDE_TRY: &h8F
        },
        MAX_INT: 2147483647,
        MIN_INT: - 2147483648
    }
end function 

' * @ignore
function internal_getDateObject() as object
    dateObj = CreateObject("roDateTime")
    utc = dateObj
    dateObj.toLocalTime()
    local = dateObj
    return {
        "utc": utc,
        "local": local
    }
end function 

' /**

' * @ignore
' * Checks if the supplied value allows for key field access
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function internal_isKeyedValueType(value as dynamic) as boolean
    return getInterface(value, "ifAssociativeArray") <> Invalid
end function 

' /**

' * Attempts to converts a nodes top level fields to an AssociativeArray.
' * @param {Dynamic} value - The variable to be converted.
' * @param {Boolean} removeId - If set to true the nodes ID will also be stripped.
' * @param {Object} removeFields - List of keys that need to be removed from the node.
' * @return {Dynamic} Results of the conversion.
' */
function internal_nodeToAA(value as object, removeId = false as boolean, removeFields = [] as object) as object
    if isNode(value) then
        fields = value.getFields()
        fields.delete("change")
        fields.delete("focusable")
        fields.delete("focusedChild")
        fields.delete("ready")
        if removeId then
            fields.delete("id")
        end if
        'Looping through any additional fields if passed.
        if isNonEmptyArray(removeFields) then
            for each field in removeFields
                fields.delete(field)
            end for
        end if
        return fields
    else if isAA(value) then
        return value
    end if
    return {}
end function 

' /**

' * Attempts to convert the supplied value to a string.
' * @param {Dynamic} value The value to convert.
' * @return {String} Results of the conversion.
' */
function nodeToString(node as object) as string
    if NOT isNode(node) then
        return ""
    end if
    description = node.subtype()
    if node.isSubtype("Group") then
        ' accessing properties from anywhere but the render thread is too expensive to include here
        id = node.id
        if id <> "" then
            description += " (" + id + ")" + internal_aaToString(internal_nodeToAA(node))
        end if
    end if
    return description
end function 

' /**

' * Attempts to convert the supplied value to a string.
' * @param {Dynamic} value The value to convert.
' * @return {String} Results of the conversion.
' */
function internal_numberToString(value as dynamic) as string
    return value.toStr()
end function 

' * @ignore
function internal_sanitizeKeyPathArray(value = "" as string)
    regex = createObject("roRegex", "\[(.*?)\]", "i")
    matches = regex.matchAll(value)
    if isNotInvalid(matches) then
        for each match in matches
            if isNotInvalid(match) then
                value = value.replace(match[0], "." + match[1])
            end if
        end for
    end if
    return value
end function 

'/**

' * Creates an array of unique values that are included in all given arrays using SameValueZero for equality comparisons. The order and references of result values are determined by the first array.
' * @param {Array} mainArray - The main array to inspect
' * @param {Array} inspect - The array to find matches
' * @return {Array} Returns the new array of intersecting values
' */
function intersection(mainArray = [] as object, inspectArray = [] as object) as object
    return intersectionBy(mainArray, inspectArray)
end function 

'/**

' * This method is like rodash.intersection except that it accepts iteratee which is invoked for each element of each arrays to generate the criterion by which they're compared. The order and references of result values are determined by the first array. The iteratee is invoked with one argument:(value).
' * @param {Array} mainArray - The main array to inspect
' * @param {Array} inspect - The array to find matches
' * @param {Dynamic} iteratee - The iteratee invoked per element
' * @return {Array} Returns the new array of intersecting values
' */
function intersectionBy(mainArray = [] as object, inspectArray = [] as object, iteratee = invalid) as object
    intersectArray = []
    mainArray = clone(mainArray)
    inspectArray = clone(inspectArray)
    if isInvalid(iteratee) then
        if isNonEmptyArray(mainArray) then
            for each item in mainArray
                if NOT isEqual(indexOf(inspectArray, item), - 1) then
                    intersectArray.push(item)
                end if
            end for
        end if
    else if isFunction(iteratee) then
        for i = 0 to inspectArray.count() - 1
            inspectArray[i] = iteratee(inspectArray[i])
        end for
        for each item in mainArray
            if NOT isEqual(indexOf(inspectArray, iteratee(item)), - 1) then
                intersectArray.push(item)
            end if
        end for
    else if isString(iteratee) then
        for each item in mainArray
            findKey = item[iteratee]
            if isNotInvalid(findKey) then
                matchValue = {}
                matchValue[iteratee] = findKey
                if NOT isEqual(findIndex(inspectArray, matchValue), - 1) then
                    intersectArray.push(item)
                end if
            end if
        end for
    end if
    return intersectArray
end function 

'/**

' * This method is like rodash.intersection except that it accepts comparator which is invoked to compare elements of arrays. The order and references of result values are determined by the first array. The comparator is invoked with two arguments: (arrVal, othVal).
' * @param {Array} mainArray - The main array to inspect
' * @param {Array} inspect - The array to find matches
' * @param {Dynamic} comparator - The comparator invoked per element
' * @return {Array} Returns the new array of intersecting values
' */
function intersectionWith(mainArray = [] as object, inspectArray = [] as object, comparator = invalid) as object
    if NOT isFunction(comparator) then
        return []
    end if
    return intersectionBy(mainArray, inspectArray, comparator)
end function 

' /**

' * Checks if the supplied value is a valid AssociativeArray type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isAA(value as dynamic)
    return type(value) = "roAssociativeArray"
end function 

' /**

' * Checks if the supplied value is a valid Array type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isArray(value as dynamic)
    return type(value) = "roArray"
end function 

' /**

' * Checks if the supplied value is a valid unempty Array like type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isArrayLike(value as dynamic)
    return isNonEmptyArray(value) OR isNonEmptyString(value)
end function 

' /**

' * Checks if the supplied value is a valid Boolean type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isBoolean(value as dynamic) as boolean
    valueType = type(value)
    return (valueType = "Boolean") OR (valueType = "roBoolean")
end function 

' /**

' * Checks if the supplied value is a valid ByteArray type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isByteArray(value as dynamic)
    return type(value) = "roByteArray"
end function 

' /**

' * Alias to isDate function
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isDate(value as dynamic) as boolean
    return isDateTime(value)
end function 

' /**

' * Checks if the supplied value is a valid date time type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isDateTime(value as dynamic) as boolean
    return ("roDateTime" = type(value))
end function 

' /**

' * Checks if the supplied value is a valid Double type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isDouble(value as dynamic) as boolean
    valueType = type(value)
    return (valueType = "Double") OR (valueType = "roDouble") OR (valueType = "roIntrinsicDouble")
end function 

' /**

' * Alias to isNode function
' * @param {Dynamic} value The variable to be checked
' * @param {String} subType An optional subType parameter to further refine the check
' * @return {Boolean} Results of the check
' */
function isElement(value as dynamic, subType = "" as string) as boolean
    return isNode(value, subtype)
end function 

function isEmpty(value as dynamic)
    if isInvalid(value) OR isNumber(value) OR isBoolean(value) then
        return true
    else if isAA(value) then
        return NOT isNonEmptyAA(value)
    else if isArray(value) then
        return NOT isNonEmptyArray(value)
    else if isString(value) then
        return isEmptyString(value)
    end if
    return true
end function 

' /**

' * Checks if the supplied value is a valid String type and is not empty
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isEmptyString(value as dynamic) as boolean
    return isString(value) AND value = ""
end function 

' /**

' * Checks if the supplied values are the same.
' * @param {Dynamic} valueOne - First value.
' * @param {Dynamic} valueTwo - Second value.
' * @return {Boolean} True if the values are the same and false if not or if any of the values are a type that could not be compared.
' */
function isEqual(valueOne as dynamic, valueTwo as dynamic) as boolean
    ' If the first argument is true we don't need to check the follwing conditionals
    if internal_canBeCompared(valueOne, valueTwo) then
        return (valueOne = valueTwo)
    else if isNode(valueOne) then
        if isNode(valueTwo) then
            return valueOne.isSameNode(valueTwo)
        end if
    else if isAA(valueOne) then
        if isAA(valueTwo) AND (join(valueOne.keys(), ",") = join(valueTwo.keys(), ",")) then
            return (formatJson(valueOne) = formatJson(valueTwo))
        end if
    else if isArray(valueOne) then
        if isArray(valueTwo) AND (valueOne.count() = valueTwo.count()) then
            return (formatJson(valueOne) = formatJson(valueTwo))
        end if
    end if
    return false
end function 

' /**

' * Checks if the supplied values are the same.
' * @param {Dynamic} valueOne - First value.
' * @param {Dynamic} valueTwo - Second value.
' * @return {Boolean} True if the values are the same and false if not or if any of the values are a type that could not be compared.
' */
function isEqualWith(valueOne as dynamic, valueTwo as dynamic, customizer = invalid) as boolean
    ' If the first argument is true we don't need to check the follwing conditionals
    ' TODO: revisit this agressively
    if internal_canBeCompared(valueOne, valueTwo) then
        return customizer(valueOne, valueTwo)
    else if isNode(valueOne) then
        if isNode(valueTwo) then
            valueOne = valueOne.getFields()
            valueOne.delete("change")
            valueOne.delete("focusable")
            valueOne.delete("focusedChild")
            valueOne.delete("ready")
            valueTwo = valueTwo.getFields()
            valueTwo.delete("change")
            valueTwo.delete("focusable")
            valueTwo.delete("focusedChild")
            valueTwo.delete("ready")
            return isEqualWith(valueOne, valueTwo, customizer)
        end if
    else if isAA(valueOne) then
        if isAA(valueTwo) AND (valueOne.keys().count() = valueTwo.keys().count()) then
            keys = valueOne.keys()
            for each key in keys
                if customizer(valueOne[key], valueTwo[key]) then
                    return true
                end if
            end for
        end if
    else if isArray(valueOne) then
        if isArray(valueTwo) AND (valueOne.count() = valueTwo.count()) then
            for i = 0 to valueOne.count() - 1
                if customizer(valueOne[i], valueTwo[i]) then
                    return true
                end if
            end for
        end if
    end if
    return false
end function 

' /**

' * Assesses the passed object to determine if it is an Error Object.
' * @param {Dynamic} value - the object to assess
' * @return {Boolean} True if the object represents and error.
' */
' TODO: MORE SUPPORT - TRY/CATCH?
function isError(value as dynamic) as boolean
    if isAA(value) then
        if isNonEmptyString(value.status) AND stringIncludes(value.status, "error") then
            return true
        end if
        errorCodes = internal_getConstants().BrightScriptErrorCodes
        if hasKeys(value, [
            "number",
            "message",
            "exception"
        ]) then
            for each errorCode in errorCodes
                if value.number = errorCode then
                    return true
                end if
            end for
        end if
    end if
    return false
end function 

function isFinite(value as dynamic) as boolean
    if NOT isNumber(value) then
        return false
    end if
    constants = internal_getConstants()
    if gt(value, constants.max_int) OR lt(value, constants.min_int) then
        return false
    end if
    return true
end function 

' /**

' * Checks if the supplied value is a valid Float type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isFloat(value as dynamic) as boolean
    valueType = type(value)
    return (valueType = "Float") OR (valueType = "roFloat")
end function 

' /**

' * Checks if the supplied value is a valid Function type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isFunction(value as dynamic) as boolean
    valueType = type(value)
    return (valueType = "roFunction") OR (valueType = "Function")
end function 

' /**

' * Checks if the supplied value is a valid Integer type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isInteger(value as dynamic) as boolean
    valueType = type(value)
    return (valueType = "Integer") OR (valueType = "roInt") OR (valueType = "roInteger") OR (valueType = "LongInteger")
end function 

' /**
' * Checks if the supplied value is Invalid
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isInvalid(value as dynamic) as boolean
    return NOT isNotInvalid(value)
end function 

' /**

' * Checks if value is a valid array-like length
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isLength(value as dynamic) as boolean
    if isInteger(value) AND isFinite(value) AND gte(value, 0) then
        return true
    end if
    return false
end function 

' /**

' * Alias to isArray function
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isMap(value as dynamic) as boolean
    return isArray(value)
end function 

' /**

' * Method determines whether the passed value is NaN and its type is a valid number
' * @param {Dynamic} value - The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNaN(value as dynamic) as boolean
    return NOT isNumber(value)
end function 

' /**

' * Checks if the supplied value is a valid Node type
' * @param {Dynamic} value The variable to be checked
' * @param {String} subType An optional subType parameter to further refine the check
' * @return {Boolean} Results of the check
' */
function isNode(value as dynamic, subType = "" as string) as boolean
    if type(value) <> "roSGNode" then
        return false
    end if
    if subType <> "" then
        return value.isSubtype(subType)
    end if
    return true
end function 

' /**

' * Checks if the supplied value is a valid and populated AssociativeArray type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNonEmptyAA(value as dynamic)
    return isAA(value) AND value.keys().count() > 0
end function 

' /**

' * Checks if the supplied value is a valid Array type and not empty
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNonEmptyArray(value as dynamic) as boolean
    return (isArray(value) AND NOT value.isEmpty())
end function 

' /**

' * Checks if the supplied value is a valid String type and is not empty
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNonEmptyString(value as dynamic) as boolean
    return isString(value) AND value <> ""
end function 

' /**

' * Checks if the supplied value is not Invalid or uninitialized
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNotInvalid(value as dynamic) as boolean
    return (type(value) <> "<uninitialized>" AND value <> Invalid)
end function 

' /**
' * Alias to isInvalid function
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNull(value as dynamic) as boolean
    return NOT isNotInvalid(value)
end function 

' /**

' * Checks if the supplied value is a valid number type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isNumber(obj as dynamic) as boolean
    if (isInteger(obj)) then
        return true
    end if
    if (isFloat(obj)) then
        return true
    end if
    if (isDouble(obj)) then
        return true
    end if
    return false
end function 

' /**

' * Checks if the supplied value is a valid String type
' * @param {Dynamic} value The variable to be checked
' * @return {Boolean} Results of the check
' */
function isString(value as dynamic)
    valueType = type(value)
    return (valueType = "String") OR (valueType = "roString")
end function 

'/**

' * Converts all elements in array into a string separated by separator.
' * @param {Array} array - The array to convert
' * @param {String} separator - The element separator
' * @return {Array} Returns the joined string
' */
function join(array = [] as object, separator = "" as string)
    return clone(array).join(separator)
end function 

function kebabCase(value = "" as string)
    value = value.replace("-", " ").replace("_", " ")
    value = value.trim()
    valueArray = value.split(" ")
    return lcase(join(valueArray, "-"))
end function 

'/**

' * Gets the last element of array.
' * @param {Array} array - The array to query
' * @return {Dynamic} Returns the last element of array
' */
function last(array = []) as dynamic
    return array[array.count() - 1]
end function 

function lowerCase(value = "" as string)
    value = value.replace("-", " ").replace("_", " ")
    value = value.trim()
    valueArray = value.split(" ")
    return lcase(join(valueArray, " "))
end function 

function lowerFirst(value = "" as string)
    value = value.trim()
    valueArray = value.split("")
    valueArray[0] = lcase(valueArray[0])
    return join(valueArray)
end function 

function lt(value as dynamic, other as dynamic)
    return value < other
end function 

function lte(value as dynamic, other as dynamic)
    return value <= other
end function 

' /**

' * Creates an array of values by running each element in collection thru iteratee. The iteratee is invoked with three arguments:(value, index|key, collection)
' * @param {Dynamic} collection - The collection to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @return {Array} Returns the new mapped array
' */
function map(collection = {} as dynamic, iteratee = invalid as dynamic)
    if NOT isArray(collection) then
        return []
    end if
    returnArray = []
    for each item in collection
        if isString(iteratee) then
            if isAA(item) then
                returnArray.push(item[iteratee])
            end if
        else if isFunction(iteratee) then
            returnArray.push(iteratee(item))
        end if
    end for
    return returnArray
end function 

' /**

' * Computes the maximum value of array. If array is empty or falsey, invalid is returned.
' * @param {Array} array - The array to iterate over
' * @return {Dynamic} Returns the maximum value
' */
function max(array = [] as object) as dynamic
    return maxBy(array)
end function 

' /**

' * Computes the maximum value of array. If array is empty or falsey, invalid is returned.
' * @param {Array} array - The array to iterate over
' * @return {Dynamic} Returns the maximum value
' */
function maxBy(array = [] as object, iteratee = invalid) as dynamic
    if isEmpty(array) then
        return invalid
    end if
    maxValue = invalid
    if isInvalid(iteratee) then
        maxValue = internal_getConstants().min_int
        for each value in array
            if gt(value, maxValue) then
                maxValue = value
            end if
        end for
    else if isFunction(iteratee) AND isAA(array[0]) then
        maxValue = array[0]
        for each value in array
            if gt(iteratee(value), iteratee(maxValue)) then
                maxValue = value
            end if
        end for
    else if isString(iteratee) AND isAA(array[0]) then
        maxValue = array[0]
        for each value in array
            if gt(value[iteratee], maxValue[iteratee]) then
                maxValue = value
            end if
        end for
    end if
    return maxValue
end function 

function mean(array)
    return meanBy(array)
end function 

function meanBy(array, iteratee = invalid)
    if isEmpty(array) then
        return invalid
    end if
    return divide(sumBy(array, iteratee), array.count())
end function 

' /**

' * Computes the minimum value of array. If array is empty or falsey, invalid is returned.
' * @param {Array} array - The array to iterate over
' * @return {Dynamic} Returns the minumum value
' */
function min(array = [] as object) as dynamic
    return minBy(array)
end function 

' /**

' * Computes the minimum value of array. If array is empty or falsey, invalid is returned.
' * @param {Array} array - The array to iterate over
' * @return {Dynamic} Returns the maximum value
' */
function minBy(array = [] as object, iteratee = invalid) as dynamic
    if isEmpty(array) then
        return invalid
    end if
    minValue = invalid
    if isInvalid(iteratee) then
        minValue = internal_getConstants().max_int
        for each value in array
            if lt(value, minValue) then
                minValue = value
            end if
        end for
    else if isFunction(iteratee) AND isAA(array[0]) then
        minValue = array[0]
        for each value in array
            if lt(iteratee(value), iteratee(minValue)) then
                minValue = value
            end if
        end for
    else if isString(iteratee) AND isAA(array[0]) then
        minValue = array[0]
        for each value in array
            if lt(value[iteratee], minValue[iteratee]) then
                minValue = value
            end if
        end for
    end if
    return minValue
end function 

function multiply(multiplier as dynamic, multiplicand as dynamic) as dynamic
    if isNaN(multiplier) OR isNaN(multiplicand) then
        return 0
    end if
    return multiplier * multiplicand
end function 

function now() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.asSeconds() + dateObj.utc.getMilliseconds(),
        "local": dateObj.utc.asSeconds() + dateObj.utc.getMilliseconds()
    }
end function 

' /**

' * Add padding to the supplied value after converting to a string. For example "1" to "01".
' * @param {String} value The value to add padding to.
' * @param {Integer} padLength The minimum output string length.
' * @param {String} paddingCharacter The string to use as padding.
' * @return {String} Resulting padded string.
' */
function paddString(value as dynamic, padLength = 2 as integer, paddingCharacter = "0" as dynamic) as string
    value = toString(value)
    while value.len() < padLength
        value = paddingCharacter + value
    end while
    return value
end function 

function random(lower = 0 as dynamic, upper = 1 as dynamic, floating = invalid) as dynamic
    offset = rnd(0)
    if (isBoolean(upper)) then
        floating = upper
        upper = 1
    end if
    inputValueIsFloat = isFloat(lower) OR isFloat(upper)
    respectFloating = isBoolean(floating) OR inputValueIsFloat
    if respectFloating AND isInvalid(floating) then
        floating = inputValueIsFloat
    end if
    roundLower = rnd(lower)
    roundUpper = rnd(upper)
    roundValue = add(roundLower, roundUpper)
    if gt(roundValue, upper) then
        roundValue = roundUpper
    end if
    if lt(roundValue, lower) then
        roundValue = roundLower
    end if
    if isInvalid(floating) OR (respectFloating AND NOT floating) then
        roundValue = cint(roundValue)
    else
        roundValue = ((roundValue - offset).toStr() + "." + offset.toStr()).toFloat()
    end if
    return roundValue
end function 

' /**

' * Reduces collection to a value which is the accumulated result of running each element in collection thru iteratee, where each successive invocation is supplied the return value of the previous. If accumulator is not given, the first element of collection is used as the initial value. The iteratee is invoked with four arguments:(accumulator, value, index|key, collection).
' * @param {Dynamic} collection - The collection to iterate over
' * @param {Dynamic} iteratee - The function invoked per iteration
' * @param {Integer} accumulator - The initial value
' * @return {Array} Returns the accumulated value
' */
function reduce(collection = invalid as dynamic, iteratee = invalid as dynamic, accumulator = invalid as dynamic)
    result = accumulator
    if isInvalid(iteratee) then
        return collection
    else if isFunction(iteratee) then
        if isArray(collection) then
            for each item in collection
                result = iteratee(result, item)
            end for
        else if isAA(collection) then
            for each key in collection.keys()
                item = collection[key]
                result = iteratee(result, item, key)
            end for
        end if
    end if
    return result
end function 

function round(number = 0, precision = 0 as integer)
    minor = number.toStr().split(".")[1]
    ? isNotInvalid(minor) ; minor
    return ceil(number, precision)
end function 

' /**

' * Used to set a nested String value in the supplied object
' * @param {Object} aa - Object to drill down into.
' * @param {String} keyPath - A dot notation based string to the expected value.
' * @param {Dynamic} value - The value to be set.
' * @return {Boolean} True if set successfully.
' */
function set(aa as object, keyPath as string, value as dynamic) as boolean
    if NOT isAA(aa) then
        return false
    end if
    level = aa
    keys = internal_sanitizeKeyPath(keyPath).tokenize(".")
    while keys.count() > 1
        key = keys.shift()
        if NOT isAA(level[key]) then
            level[key] = {}
        end if
        level = level[key]
    end while
    finalKey = keys.shift()
    level[finalKey] = value
    return true
end function 

' /**

' * Creates an array of shuffled values, using a version of the Fisher-Yates shuffle.
' * @param {Dynamic} collection - The collection to shuffle
' * @return {Array} Returns the new shuffled array
' */
function shuffle(collection = [] as dynamic)
    if isInvalid(collection) OR (NOT isArray(collection) AND NOT isAA(collection)) then
        return []
    end if
    if isAA(collection) then
        collection = toArray(collection)
    end if
    length = collection.count() - 1
    if isEqual(length, - 1) then
        return []
    end if
    index = - 1
    lastIndex = length - 1
    result = clone(collection)
    while index < length
        index++
        rand = index + floor(random(0, 1, true) * (lastIndex - index + 1))
        value = result[rand]
        result[rand] = result[index]
        result[index] = value
    end while
    return result
end function 

' /**
' * Gets the size of collection by returning its length for array-like values or the number of own enumerable string keyed properties for objects.
' * @param {Dynamic} collection - The collection to inspect
' * @return {Integer} Returns the collection size.
' */
function size(collection = invalid as dynamic)
    if isInvalid(collection) OR (NOT isArray(collection) AND NOT isAA(collection) AND NOT isString(collection)) then
        return []
    end if
    if isAA(collection) then
        collection = toArray(collection)
    else if isString(collection) then
        return collection.len()
    end if
    return collection.count()
end function 

'/**

' * Creates a slice of array from start up to, but not including, end.
' * @param {Array} array - The array to slice
' * @param {Integer} startPos - The start position
' * @param {Integer} endPos - The end position
' * @return {Dynamic} Returns the slice of array
' */
function slice(array = [] as object, startPos = 0, endPos = invalid)
    if NOT isArray(array) then
        return invalid
    end if
    if isNotInvalid(endPos) then
        endPos = endPos - 1
    end if
    array = clone(array)
    arraySize = array.count()
    lastIndex = arraySize - 1
    slicedArray = []
    if startPos < 0 then
        startPos = arraySize + startPos
    end if
    if endPos = invalid then
        endPos = lastIndex
    end if
    if endPos < 0 then
        endPos = arraySize + endPos
    end if
    if endPos >= arraySize then
        endPos = lastIndex
    end if
    if startPos >= arraySize OR startPos > endPos then
        return slicedArray
    end if
    for i = startPos to endPos
        slicedArray.push(array[i])
    end for
    return slicedArray
end function 

' /**

' * Creates an array of elements, sorted in ascending order by the results of running each element in a collection thru each iteratee. This method performs a stable sort, that is, it preserves the original sort order of equal elements. The iteratees are invoked with one argument: (value).
' * @param {Dynamic} collection - The collection to shuffle
' * @param {Dynamic} iteratee - The iteratees to sort by
' * @return {Array} Returns the new sorted array
' */
function sortBy(collection = invalid as dynamic, iteratee = invalid as dynamic)
    if isInvalid(collection) OR NOT isArray(collection) then
        return collection
    end if
    returnCollection = clone(collection)
    if isArray(iteratee) then
        for each iteration in iteratee
            if isString(iteration) then
                returnCollection.sortBy(iteration)
            end if
        end for
    else if isFunction(iteratee) then
        key = ""
        for each aa in collection
            for each key in aa.keys()
                if isEqual(aa[key], iteratee(aa)) then
                    exit for
                end if
            end for
            if NOT key = "" then
                exit for
            end if
        end for
        if NOT key = "" then
            returnCollection.sortBy(key)
        end if
    end if
    return returnCollection
end function 

'/**
' * Uses a binary search to determine the lowest index at which value should be inserted into array in order to maintain its sort order.
' * @param {Array} array - The sorted array to inspect
' * @return {Object} Returns the index at which value should be inserted into array
' */
function sortedIndex(array = [] as object, value = 0 as integer)
    for i = 0 to array.count() - 1
        item = array[i]
        nextItem = array[i + 1]
        if isNotInvalid(nextItem) then
            if (item >= value AND value <= nextItem) then
                return i
            end if
        end if
    end for
    return i
end function 

' /**

' * Check for the existence of a given sub string
' * @param {String} value The string to search
' * @param {String} subString The sub string to search for
' * @return {Boolean} Results of the search
' */
function stringIncludes(value as string, subString as string) as boolean
    return stringIndexOf(value, subString) > - 1
end function 

' /**

' * Finds the sub string index position
' * @param {String} value The string to search
' * @param {String} subString The sub string to search for
' * @return {Integer} Results of the search
' */
function stringIndexOf(value as string, subString as string) as integer
    return value.Instr(subString)
end function 

'/**
' * Subtract two numbers.
' * @param {Integer} minuend - The first number in a subtraction
' * @param {Integer} subtrahend - The second number in a subtraction
' * @return {Integer} Returns the difference.
' */
function subtract(minuend as dynamic, subtrahend as dynamic) as dynamic
    if isNaN(minuend) OR isNaN(subtrahend) then
        return 0
    end if
    return minuend - subtrahend
end function 

function sum(array as object)
    sumValue = 0
    for each item in array
        sumValue += item
    end for
    return sumValue
end function 

function sumBy(array = [] as object, iteratee = invalid) as dynamic
    if isEmpty(array) then
        return invalid
    end if
    sumValue = invalid
    if isInvalid(iteratee) then
        sumValue = 0
        for each value in array
            sumValue += value
        end for
    else if isFunction(iteratee) AND isAA(array[0]) then
        sumValue = 0
        for each value in array
            sumValue += iteratee(value)
        end for
    else if isString(iteratee) AND isAA(array[0]) then
        sumValue = 0
        for each value in array
            sumValue += value[iteratee]
        end for
    end if
    return sumValue
end function 

'/**

' * Creates a slice of array with n elements taken from the beginning
' * @param {Array} array - The sorted array to query
' * @param {Integer} n - The number of elements to take
' * @return {Object} Returns the slice of array
' */
function take(array = [] as object, n = invalid as dynamic) as object
    if isInvalid(n) then
        n = 1
    end if
    if NOT isNonEmptyArray(array) OR n = 0 then
        return []
    end if
    return slice(array, 0, n)
end function 

'/**

' * Creates a slice of array with n elements taken from the end
' * @param {Array} array - The sorted array to query
' * @param {Integer} n - The number of elements to take
' * @return {Object} Returns the slice of array
' */
function takeRight(array = [] as object, n = invalid as dynamic) as object
    if isInvalid(n) then
        n = 1
    end if
    if NOT isNonEmptyArray(array) OR n = 0 then
        return []
    end if
    length = array.count()
    startPos = length - n
    if startPos < 0 then
        startPos = 0
    end if
    return slice(array, startPos, length)
end function 

' /**
'TODO: ADD MORE SUPPORT

' * Attempts to convert the supplied value to a array.
' * @param {Dynamic} value The value to convert.
' * @return {Object} Results of the conversion.
' */
function toArray(aa as object) as object
    array = []
    for each key in aa
        value = aa[key]
        index = get(value, "index")
        if isNumber(index) then
            array.setEntry(index, value)
        else
            array.push(value)
        end if
    end for
    return array
end function 

function toISOString() as object
    dateObj = internal_getDateObject()
    return {
        "utc": dateObj.utc.toISOString(),
        "local": dateObj.local.toISOString()
    }
end function 

' /**

' * Attempts to convert the supplied value into a valid number
' * @param {Dynamic} value The variable to be converted
' * @return {Dynamic} Results of the conversion
' */
function toNumber(value as dynamic) as dynamic
    if isNumber(value) then
        return value
    else if isBoolean(value) then
        if value then
            return 1
        end if
        return 0
    end if
    if isString(value) then
        ' TODO: Temporary fix until we figure a better way to avoid val converting 8037667 to 8.03767e+06
        if stringIncludes(value, ".") then
            return val(value)
        else
            return val(value, 10)
        end if
    end if
    return 0
end function 

' /**

' * Attempts to convert the supplied value to a string.
' * @param {Dynamic} value The value to convert.
' * @return {String} Results of the conversion.
' */
function toString(value as dynamic) as string
    if isString(value) then
        return value
    end if
    if isNumber(value) then
        return internal_numberToString(value)
    end if
    if isNode(value) then
        return internal_nodeToString(value)
    end if
    if isBoolean(value) then
        return internal_booleanToString(value)
    end if
    if isAA(value) then
        return internal_aaToString(value)
    end if
    if isArray(value) then
        return internal_arrayToString(value)
    end if
    return ""
end function 

'/**
' * Creates an array of unique values, in order, from all given arrays using SameValueZero for equality comparisons.
' * @param {Array} arrays - The arrays to inspect
' * @return {Object} Returns the new array of combined values
' */
function union(arrays = [] as object) as object
    return uniq(flattenDeep(arrays))
end function 

'/**

' * Creates a duplicate-free version of an array, using SameValueZero for equality comparisons, in which only the first occurrence of each element is kept. The order of result values is determined by the order they occur in the array.
' * @param {Array} array - The array to inspect
' * @return {Object} Returns the new duplicate free array
' */
function uniq(array = [] as object) as object
    returnArray = []
    table = {}
    for each item in array
        key = item.toStr()
        if not table.doesExist(key) then
            returnArray.push(item)
            table[key] = true
        end if
    end for
    return returnArray
end function 

'/**

' * Creates an array of grouped elements, the first of which contains the first elements of the given arrays, the second of which contains the second elements of the given arrays, and so on.
' * @param {Array} arrays - The property identifiers
' * @return {Object} Returns the new array of grouped elements
' */
function zip(arrays = [] as object) as object
    returnArray = []
    for i = 0 to arrays.count() - 1
        array = arrays[i]
        for ii = 0 to array.count() - 1
            if isInvalid(returnArray[ii]) then
                returnArray[ii] = []
            end if
            returnArray[ii].push(array[ii])
        end for
    end for
    return returnArray
end function 

'/**

' * This method is like rodash.fromPairs except that it accepts two arrays, one of property identifiers and one of corresponding values.
' * @param {Array} array - The property identifiers
' * @param {Array} values - The property identifiers
' * @return {Object} Returns the new object
' */
function zipObject(props = [] as object, values = [] as object) as object
    returnObject = {}
    for i = 0 to props.count() - 1
        returnObject[props[i]] = values[i]
    end for
    return returnObject
end function 

'/**

' * This method is like rodash.zipObject except that it supports property paths.
' * @param {Array} array - The property identifiers
' * @param {Array} values - The property identifiers
' * @return {Object} Returns the new object
' */
function zipObjectDeep(props = [] as object, values = [] as object) as object
    ' COME BACK
end function 
