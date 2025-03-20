encodedData = ""
byteCapacity = 0
totalDataCodewords = 0
ecCodewordsPerBlock = 0
numBlocksGroup1 = 0
dataCodewordsGroup1 = 0
numBlocksGroup2 = 0
dataCodewordsGroup2 = 0
version = 0
ecLevel = 0

local byteCapacities = {
    [1] = {17, 14, 11, 7}, [2] = {32, 26, 20, 14}, [3] = {53, 42, 32, 24},
    [4] = {78, 62, 46, 34}, [5] = {106, 84, 60, 44}, [6] = {134, 106, 74, 58},
    [7] = {154, 122, 86, 64}, [8] = {192, 152, 108, 84}, [9] = {230, 180, 130, 98},
    [10] = {271, 213, 151, 119}, [11] = {321, 251, 177, 137}, [12] = {367, 287, 203, 155},
    [13] = {425, 331, 241, 177}, [14] = {458, 362, 258, 194}, [15] = {520, 412, 292, 220},
    [16] = {586, 450, 322, 250}, [17] = {644, 504, 364, 280}, [18] = {718, 560, 394, 310},
    [19] = {792, 624, 442, 338}, [20] = {858, 666, 482, 382}, [21] = {929, 711, 509, 403},
    [22] = {1003, 779, 565, 439}, [23] = {1091, 857, 611, 461}, [24] = {1171, 911, 661, 511},
    [25] = {1273, 997, 715, 535}, [26] = {1367, 1059, 751, 593}, [27] = {1465, 1125, 805, 625},
    [28] = {1528, 1190, 868, 658}, [29] = {1628, 1264, 908, 698}, [30] = {1732, 1370, 982, 742},
    [31] = {1840, 1452, 1030, 790}, [32] = {1952, 1538, 1112, 842}, [33] = {2068, 1628, 1168, 898},
    [34] = {2188, 1722, 1228, 958}, [35] = {2303, 1809, 1283, 983}, [36] = {2431, 1911, 1351, 1051},
    [37] = {2563, 1989, 1423, 1093}, [38] = {2699, 2099, 1499, 1139}, [39] = {2809, 2213, 1579, 1219},
    [40] = {2953, 2331, 1663, 1273}
}

local ecTable = {
    {19, 7, 1, 19, 0, 0}, {16, 10, 1, 16, 0, 0}, {13, 13, 1, 13, 0, 0}, {9, 17, 1, 9, 0, 0},
    {34, 10, 1, 34, 0, 0}, {28, 16, 1, 28, 0, 0}, {22, 22, 1, 22, 0, 0}, {16, 28, 1, 16, 0, 0},
    {55, 15, 1, 55, 0, 0}, {44, 26, 1, 44, 0, 0}, {34, 18, 2, 17, 0, 0}, {26, 22, 2, 13, 0, 0},
    {80, 20, 1, 80, 0, 0}, {64, 18, 2, 32, 0, 0}, {48, 26, 2, 24, 0, 0}, {36, 16, 4, 9, 0, 0},
    {108, 26, 1, 108, 0, 0}, {86, 24, 2, 43, 0, 0}, {62, 18, 2, 15, 2, 16}, {46, 22, 2, 11, 2, 12},
    {136, 18, 2, 68, 0, 0}, {108, 16, 4, 27, 0, 0}, {76, 24, 4, 19, 0, 0}, {60, 28, 4, 15, 0, 0},
    {156, 20, 2, 78, 0, 0}, {124, 18, 4, 31, 0, 0}, {88, 18, 2, 14, 4, 15}, {66, 26, 4, 13, 1, 14},
    {194, 24, 2, 97, 0, 0}, {154, 22, 2, 38, 2, 39}, {110, 22, 4, 18, 2, 19}, {86, 26, 4, 14, 2, 15},
    {232, 30, 2, 116, 0, 0}, {182, 22, 3, 36, 2, 37}, {132, 20, 4, 16, 4, 17}, {100, 24, 4, 12, 4, 13},
    {274, 18, 2, 68, 2, 69}, {216, 26, 4, 43, 1, 44}, {154, 24, 6, 19, 2, 20}, {122, 28, 6, 15, 2, 16},
    {324, 20, 4, 81, 0, 0}, {254, 18, 1, 50, 4, 51}, {180, 24, 4, 22, 4, 23}, {140, 22, 3, 12, 8, 13},
    {370, 24, 2, 92, 2, 93}, {290, 22, 6, 36, 2, 37}, {206, 20, 4, 20, 6, 21}, {158, 26, 7, 14, 4, 15},
    {428, 26, 4, 107, 0, 0}, {334, 22, 8, 37, 1, 38}, {244, 24, 8, 20, 4, 21}, {180, 22, 12, 11, 4, 12},
    {461, 30, 3, 115, 1, 116}, {365, 24, 4, 40, 5, 41}, {261, 20, 11, 16, 5, 17}, {197, 24, 11, 12, 5, 13},
    {523, 22, 5, 87, 1, 88}, {415, 24, 5, 41, 5, 42}, {295, 30, 5, 24, 7, 25}, {223, 24, 11, 12, 7, 13},
    {589, 24, 5, 98, 1, 99}, {453, 28, 7, 45, 3, 46}, {325, 24, 15, 19, 2, 20}, {253, 30, 3, 15, 13, 16},
    {647, 28, 1, 107, 5, 108}, {507, 28, 10, 46, 1, 47}, {367, 28, 1, 22, 15, 23}, {283, 28, 2, 14, 17, 15},
    {721, 30, 5, 120, 1, 121}, {563, 26, 9, 43, 4, 44}, {397, 28, 17, 22, 1, 23}, {313, 28, 2, 14, 19, 15},
    {795, 28, 3, 113, 4, 114}, {627, 26, 3, 44, 11, 45}, {445, 26, 17, 21, 4, 22}, {341, 26, 9, 13, 16, 14},
    {861, 28, 3, 107, 5, 108}, {669, 26, 3, 41, 13, 42}, {485, 30, 15, 24, 5, 25}, {385, 28, 15, 15, 10, 16},
    {932, 28, 4, 116, 4, 117}, {714, 26, 17, 42, 0, 0}, {512, 28, 17, 22, 6, 23}, {406, 30, 19, 16, 6, 17},
    {1006, 28, 2, 111, 7, 112}, {782, 28, 17, 46, 0, 0}, {568, 30, 7, 24, 16, 25}, {442, 24, 34, 13, 0, 0},
    {1094, 30, 4, 121, 5, 122}, {860, 28, 4, 47, 14, 48}, {614, 30, 11, 24, 14, 25}, {464, 30, 16, 15, 14, 16},
    {1174, 30, 6, 117, 4, 118}, {914, 28, 6, 45, 14, 46}, {664, 30, 11, 24, 16, 25}, {514, 30, 30, 16, 2, 17},
    {1276, 26, 8, 106, 4, 107}, {1000, 28, 8, 47, 13, 48}, {718, 30, 7, 24, 22, 25}, {538, 30, 22, 15, 13, 16},
    {1370, 28, 10, 114, 2, 115}, {1062, 28, 19, 46, 4, 47}, {754, 28, 28, 22, 6, 23}, {596, 30, 33, 16, 4, 17},
    {1468, 30, 8, 122, 4, 123}, {1128, 28, 22, 45, 3, 46}, {808, 30, 8, 23, 26, 24}, {628, 30, 12, 15, 28, 16},
    {1531, 30, 3, 117, 10, 118}, {1193, 28, 3, 45, 23, 46}, {871, 30, 4, 24, 31, 25}, {661, 30, 11, 15, 31, 16},
    {1631, 30, 7, 115, 7, 116}, {1267, 28, 21, 45, 7, 46}, {911, 30, 1, 23, 37, 24}, {701, 30, 19, 15, 26, 16},
    {1735, 30, 5, 115, 10, 116}, {1373, 28, 19, 47, 10, 48}, {985, 30, 15, 24, 25, 25}, {745, 30, 23, 15, 25, 16},
    {1843, 30, 13, 115, 3, 116}, {1455, 28, 2, 46, 29, 47}, {1033, 30, 42, 24, 1, 25}, {793, 30, 23, 15, 28, 16},
    {1955, 30, 17, 115, 0, 0}, {1541, 28, 10, 46, 23, 47}, {1115, 30, 10, 24, 35, 25}, {845, 30, 19, 15, 35, 16},
    {2071, 30, 17, 115, 1, 116}, {1631, 28, 14, 46, 24, 47}, {1171, 30, 29, 24, 19, 25}, {901, 30, 11, 15, 46, 16},
    {2191, 30, 13, 115, 6, 116}, {1725, 28, 14, 46, 28, 47}, {1231, 30, 44, 24, 7, 25}, {961, 30, 59, 16, 1, 17},
    {2306, 30, 12, 121, 7, 122}, {1812, 28, 12, 47, 26, 48}, {1286, 30, 39, 24, 14, 25}, {986, 30, 22, 15, 41, 16},
    {2434, 30, 6, 121, 14, 122}, {1914, 28, 6, 47, 34, 48}, {1354, 30, 46, 24, 10, 25}, {1054, 30, 2, 15, 64, 16},
    {2566, 30, 17, 122, 4, 123}, {1992, 28, 29, 46, 14, 47}, {1426, 30, 49, 24, 10, 25}, {1096, 30, 24, 15, 46, 16},
    {2702, 30, 4, 122, 18, 123}, {2102, 28, 13, 46, 32, 47}, {1502, 30, 48, 24, 14, 25}, {1142, 30, 42, 15, 32, 16},
    {2812, 30, 20, 117, 4, 118}, {2216, 28, 40, 47, 7, 48}, {1582, 30, 43, 24, 22, 25}, {1222, 30, 10, 15, 67, 16},
    {2956, 30, 19, 118, 6, 119}, {2334, 28, 18, 47, 31, 48}, {1666, 30, 34, 24, 34, 25}, {1276, 30, 20, 15, 61, 16}
}

function main()

    local input = "Hello World! How are you today? How are you feeling? You doing alright? Good! I'm glad."
    local ECLevel = "H" --L,M,Q,H

    if ECLevel == "L" then
        ecLevel = 0
    elseif ECLevel == "M" then
        ecLevel = 1
    elseif ECLevel == "Q" then
        ecLevel = 2
    elseif ECLevel == "H" then
        ecLevel = 3
    else
        ecLevel = 0
    end

    -- Step 1: Set the version based on the input length
    setVersion(input)
    if version ~= -1 then
        local index = (version - 1) * 4 + ecLevel

        byteCapacity = byteCapacities[version][ecLevel + 1]
        totalDataCodewords = ecTable[index + 1][1]
        ecCodewordsPerBlock = ecTable[index + 1][2]
        numBlocksGroup1 = ecTable[index + 1][3]
        dataCodewordsGroup1 = ecTable[index + 1][4]
        numBlocksGroup2 = ecTable[index + 1][5]
        dataCodewordsGroup2 = ecTable[index + 1][6]

        print("Version: " .. version)
    else
        print("too long")
        return
    end

    -- Step 2: Encode the input data into binary
    encodedData = encodeToBinary(input)

    local dataCodewords = splitIntoCodewords(encodedData)

    -- Step 3: Split codewords into blocks
    local dataBlocks = splitIntoBlocks(dataCodewords)

    -- Step 4: Generate error correction codewords for each block
    local eccBlocks = {}
    for _, block in ipairs(dataBlocks) do
        local data = {}
        for i, v in ipairs(block) do
            data[i] = tonumber(v, 2)
        end
        local eccCodewords = reedSolomonEncode(data, ecCodewordsPerBlock)
        local eccBinary = {}
        for i, v in ipairs(eccCodewords) do
            eccBinary[i] = toBinary(v, 8)
        end
        table.insert(eccBlocks, eccBinary)
    end

    -- Step 5: Interleave data and error correction codewords into the final message
    local finalMessage = interleaveBlocks(dataBlocks, eccBlocks)
    finalMessage = finalMessage .. getRemainderBits(version)
   
    print(finalMessage)
    print(version)
    print(byteCapacity)
    print(totalDataCodewords)
    print(ecCodewordsPerBlock)
    print(numBlocksGroup1)
    print(dataCodewordsGroup1)
    print(numBlocksGroup2)
    print(dataCodewordsGroup2)
   
    --MatrixBuilder(finalMessage, version, ecLevel)
    local matrixBuilder = MatrixBuilder:new(finalMessage, version, ecLevel)
    -- print("\nQR Code saved as qrcode.html")
    
    -- os.execute("start qrcode.html")

    --make image for calculator
    qrMatrix = matrixBuilder.matrix
    qrSize = matrixBuilder.printSize
    
    
end

function setVersion(input)
    local length = #input -- Byte Mode length
    for i = 1, #byteCapacities do
        if length <= byteCapacities[i][ecLevel + 1] then
            version = i
            return
        end
    end
    version = -1
end

function encodeToBinary(input)
    local result = ""

    -- add mode indicator always
    result = result .. "0100"
    local bitLength = 0
    if version >= 1 and version <= 9 then
        bitLength = 8
    elseif version >= 10 and version <= 40 then
        bitLength = 16
    end
    result = result .. toBinary(#input, bitLength)

    for i = 1, #input do
        result = result .. toBinary(input:byte(i), 8)
    end

    --Step 4: Add Terminator Bits
    while (totalDataCodewords * 8) - #result > 0 do
        if (totalDataCodewords * 8) - #result >= 4 then
            result = result .. "0000"
            break
        else
            result = result .. '0'
        end
    end

    local terminatorBits = math.min(4, (totalDataCodewords * 8) - #result)
    for i = 1, terminatorBits do
        result = result .. '0'
    end

    -- Step 5: Pad to full byte (8-bit boundary)
    while #result % 8 ~= 0 do
        result = result .. '0'
    end

    -- Step 6: Add Padding Bytes (0xEC and 0x11 alternately)
    local paddingByte1 = "11101100" -- 0xEC
    local paddingByte2 = "00010001" -- 0x11
    local currentBitLength = #result

    while currentBitLength < (totalDataCodewords * 8) do
        result = result .. paddingByte1
        currentBitLength = currentBitLength + 8
        if currentBitLength < (totalDataCodewords * 8) then
            result = result .. paddingByte2
            currentBitLength = currentBitLength + 8
        end
    end

    return result
end

-- Converts an integer to a binary string with a fixed number of bits.
function toBinary(value, bitLength)
    local binaryString = ""
    while value > 0 do
        binaryString = tostring(value % 2) .. binaryString
        value = math.floor(value / 2)
    end
    while #binaryString < bitLength do
        binaryString = "0" .. binaryString
    end
    return binaryString
end

function bitwise_xor(a, b)
    local result = 0
    local bit = 1
    while a > 0 or b > 0 do
        local a_bit = a % 2
        local b_bit = b % 2
        if a_bit ~= b_bit then
            result = result + bit
        end
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        bit = bit * 2
    end
    return result
end

-- Error-Correction
local logTable = {}
local expTable = {}
local fieldSize = 256

local x = 1
for i = 0, 254 do
    expTable[i] = x
    logTable[x] = i
    x = x * 2
    if x >= 256 then
        x = bitwise_xor(x, 0x11D) -- XOR with the primitive polynomial x^8 + x^4 + x^3 + x^2 + 1
    end
end
expTable[255] = 1

-- GF(256) addition (XOR)
function gfAdd(a, b)
    return bitwise_xor(a, b)
end

-- GF(256) multiplication
function gfMultiply(a, b)
    if a == 0 or b == 0 then
        return 0
    end
    return expTable[(logTable[a] + logTable[b]) % 255]
end

-- Generate the generator polynomial for the given error correction length
function generateGeneratorPolynomial(errorCorrectionLength)
    local generator = {1}

    for i = 0, errorCorrectionLength - 1 do
        local temp = {1, expTable[i]}
        generator = multiplyPolynomials(generator, temp)
    end

    return generator
end

-- Multiply two polynomials in GF(256)
function multiplyPolynomials(a, b)
    local result = {}
    for i = 1, #a + #b - 1 do
        result[i] = 0
    end
    for i = 1, #a do
        for j = 1, #b do
            result[i + j - 1] = gfAdd(result[i + j - 1], gfMultiply(a[i], b[j]))
        end
    end
    return result
end

-- Reed-Solomon encode data
function reedSolomonEncode(data, errorCorrectionLength)
    local generator = generateGeneratorPolynomial(errorCorrectionLength)
    local encoded = {}
    for i = 1, #data do
        encoded[i] = data[i]
    end
    for i = #data + 1, #data + errorCorrectionLength do
        encoded[i] = 0
    end

    for i = 1, #data do
        local coef = encoded[i]
        if coef ~= 0 then
            for j = 1, #generator do
                encoded[i + j - 1] = gfAdd(encoded[i + j - 1], gfMultiply(coef, generator[j]))
            end
        end
    end

    local result = {}
    for i = #data + 1, #encoded do
        result[i - #data] = encoded[i]
    end
    return result
end

-- Split encoded data into codewords
function splitIntoCodewords(encodedData)
    local codewordLength = 8 -- Each codeword is 8 bits
    local numCodewords = math.floor(#encodedData / codewordLength)
    local codewords = {}
    for i = 0, numCodewords - 1 do
        codewords[i + 1] = encodedData:sub(i * codewordLength + 1, (i + 1) * codewordLength)
    end
    return codewords
end

-- Split codewords into blocks
function splitIntoBlocks(dataCodewords)
    local blocks = {}

    -- Split into Group 1 blocks
    for i = 0, numBlocksGroup1 - 1 do
        local block = {}
        for j = 0, dataCodewordsGroup1 - 1 do
            block[j + 1] = dataCodewords[i * dataCodewordsGroup1 + j + 1]
        end
        table.insert(blocks, block)
    end

    -- Split into Group 2 blocks (if applicable)
    if numBlocksGroup2 > 0 then
        local startIndex = numBlocksGroup1 * dataCodewordsGroup1
        for i = 0, numBlocksGroup2 - 1 do
            local block = {}
            for j = 0, dataCodewordsGroup2 - 1 do
                block[j + 1] = dataCodewords[startIndex + i * dataCodewordsGroup2 + j + 1]
            end
            table.insert(blocks, block)
        end
    end

    return blocks
end

-- Interleave data and error correction codewords into the final message
function interleaveBlocks(dataBlocks, eccBlocks)
    local finalMessage = ""

    -- Interleave data codewords
    local maxDataCodewords = math.max(dataCodewordsGroup1, dataCodewordsGroup2)
    for i = 0, maxDataCodewords - 1 do
        for _, block in ipairs(dataBlocks) do
            if i < #block then
                finalMessage = finalMessage .. block[i + 1]
            end
        end
    end

    -- Interleave error correction codewords
    local maxEccCodewords = ecCodewordsPerBlock
    for i = 0, maxEccCodewords - 1 do
        for _, block in ipairs(eccBlocks) do
            if i < #block then
                finalMessage = finalMessage .. block[i + 1]
            end
        end
    end

    return finalMessage
end

function getRemainderBits(version)
    -- The number of required remainder bits for each QR code version
    local remainderBits = {
        0, 7, 7, 7, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0
    }

    local bits = remainderBits[version]
    return string.rep("0", bits)
end

-- MatrixBuilder class
MatrixBuilder = {}
MatrixBuilder.__index = MatrixBuilder
MatrixBuilder.filled = {}
MatrixBuilder.matrix = {}
MatrixBuilder.message = ""
MatrixBuilder.printSize = 0
MatrixBuilder.maskType = 0

local formatInfo0 = {
    "111011111000100", -- L, 0
    "111001011110011", -- L, 1
    "111110110101010", -- L, 2
    "111100010011101", -- L, 3
    "110011000101111", -- L, 4
    "110001100011000", -- L, 5
    "110110001000001", -- L, 6
    "110100101110110"  -- L, 7
}

local formatInfo1 = {
    "101010000010010", -- M, 0
    "101000100100101", -- M, 1
    "101111001111100", -- M, 2
    "101101101001011", -- M, 3
    "100010111111001", -- M, 4
    "100000011001110", -- M, 5
    "100111110010111", -- M, 6
    "100101010100000"  -- M, 7
}

local formatInfo2 = {
    "011010101011111", -- Q, 0
    "011000001101000", -- Q, 1
    "011111100110001", -- Q, 2
    "011101000000110", -- Q, 3
    "010010010110100", -- Q, 4
    "010000110000011", -- Q, 5
    "010111011011010", -- Q, 6
    "010101111101101"  -- Q, 7
}

local formatInfo3 = {
    "001011010001001", -- H, 0
    "001001110111110", -- H, 1
    "001110011100111", -- H, 2
    "001100111010000", -- H, 3
    "000011101100010", -- H, 4
    "000001001010101", -- H, 5
    "000110100001100", -- H, 6
    "000100000111011"  -- H, 7
}

local versionFormats = {
    [7] = "000111110010010100",
    [8] = "001000010110111100",
    [9] = "001001101010011001",
    [10] = "001010010011010011",
    [11] = "001011101111110110",
    [12] = "001100011101100010",
    [13] = "001101100001000111",
    [14] = "001110011000001101",
    [15] = "001111100100101000",
    [16] = "010000101101111000",
    [17] = "010001010001011101",
    [18] = "010010101000010111",
    [19] = "010011010100110010",
    [20] = "010100100110100110",
    [21] = "010101011010000011",
    [22] = "010110100011001001",
    [23] = "010111011111101100",
    [24] = "011000111011000100",
    [25] = "011001000111100001",
    [26] = "011010111110101011",
    [27] = "011011000010001110",
    [28] = "011100110000011010",
    [29] = "011101001100111111",
    [30] = "011110110101110101",
    [31] = "011111001001010000",
    [32] = "100000100111010101",
    [33] = "100001011011110000",
    [34] = "100010100010111010",
    [35] = "100011011110011111",
    [36] = "100100101100001011",
    [37] = "100101010000101110",
    [38] = "100110101001100100",
    [39] = "100111010101000001",
    [40] = "101000110001101001"
}

-- MatrixBuilder class
-- Global variables to store the QR code matrix and size
qrMatrix = {}
qrSize = 0

function on.create()
    main() -- Generate the QR code matrix
    platform.window:invalidate() -- Refresh the screen to draw
end

function on.paint(gc)
    -- Clear the screen with white background
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(0, 0, platform.window:width(), platform.window:height())
    
    if qrSize == 0 then
        return -- QR code not generated yet
    end
    
    -- Calculate cell size to fit the QR code on the screen
    local screenWidth = platform.window:width()
    local screenHeight = platform.window:height()
    local cellSize = math.min(screenWidth / qrSize, screenHeight / qrSize)
    
    -- Calculate starting position to center the QR code
    local startX = (screenWidth - cellSize * qrSize) / 2
    local startY = (screenHeight - cellSize * qrSize) / 2
    
    -- Draw each module of the QR code
    gc:setColorRGB(0, 0, 0) -- Black color for modules
    for row = 1, qrSize do
        for col = 1, qrSize do
            if qrMatrix[row][col] == 1 then
                gc:fillRect(startX + (col-1)*cellSize, startY + (row-1)*cellSize, cellSize, cellSize)
            end
        end
    end
end

function MatrixBuilder:new(text, versionInput, ecLevel)
    local self = setmetatable({}, MatrixBuilder)
    self.message = text
    self.printSize = 21 + ((versionInput - 1) * 4)
    self.maskType = 0

    -- Initialize matrix and filled tables
    self.matrix = {}
    self.filled = {}
    for i = 1, self.printSize do
        self.matrix[i] = {}
        self.filled[i] = {}
        for j = 1, self.printSize do
            self.matrix[i][j] = 0
            self.filled[i][j] = false
        end
    end

    print("MatrixBuilder initialized with size: " .. self.printSize)

    -- Call the initialization logic
    self:__init(text, versionInput, ecLevel)
    return self
end

function MatrixBuilder:__init(text, versionInput, ecLevel)
    local version = versionInput
    local size = 21 + ((version - 1) * 4)
    local lowestScore = 10000000
    local score
    local bitCount = size * size -- 625 (25x25)

    for i = 0, 7 do
        -- Reset only the mask type, not the entire matrix
        self.maskType = i
       
       
       
        self.matrix = {}
    self.filled = {}
    for i = 1, self.printSize do
        self.matrix[i] = {}
        self.filled[i] = {}
        for j = 1, self.printSize do
            self.matrix[i][j] = 0
            self.filled[i][j] = false
        end
    end
       
       

        self:addFinderPatterns()
        self:addSeparators()
        self:addTimingPatterns()
        self:addDarkModule(version)
        self:addAlignmentPatterns(version)
        self:addReservedAreas(version, size)
        self:fill(size, size, 1, true, bitCount)
        self:PlaceLastBit(size, tonumber(self.message:sub(-1)), version)

        self:addFormatInfo(version, size, ecLevel, i)

        score = calculatePenalty(self.matrix)
        print("Mask: " .. i .. "|Score: " .. score)

        if score < lowestScore then
            lowestScore = score
            self.maskType = i
        end
    end

    -- Reset only the mask type for the final selected mask
    self.maskType = lowestScore
   
    self.maskType = 0
    print(self.maskType)
   
   
   
    self.matrix = {}
    self.filled = {}
    for i = 1, self.printSize do
        self.matrix[i] = {}
        self.filled[i] = {}
        for j = 1, self.printSize do
            self.matrix[i][j] = 0
            self.filled[i][j] = false
        end
    end
   
   
   
   
   

    self:addFinderPatterns()
    self:addSeparators()
    self:addTimingPatterns()
    self:addDarkModule(version)
    self:addAlignmentPatterns(version)
    self:addReservedAreas(version, size)
    self:fill(size, size, 1, true, bitCount)
    self:PlaceLastBit(size, tonumber(self.message:sub(-1)), version)

    self:addFormatInfo(version, size, ecLevel, self.maskType)

    print("Selected Mask: " .. self.maskType)
end

function MatrixBuilder:addFinderPattern(startRow, startCol)
    print("Adding finder pattern at (" .. startRow .. ", " .. startCol .. ")")
    for i = 0, 6 do
        for j = 0, 6 do
            local row = startRow + i
            local col = startCol + j
            -- Check if indices are within bounds (1-based indexing)
            if row >= 1 and row <= #self.matrix and col >= 1 and col <= #self.matrix[1] then
                if i == 0 or i == 6 or j == 0 or j == 6 or (i >= 2 and i <= 4 and j >= 2 and j <= 4) then
                    self.matrix[row][col] = 1
                    self.filled[row][col] = true
                else
                    self.matrix[row][col] = 0
                    self.filled[row][col] = true
                end
            else
                print("Index out of bounds: (" .. row .. ", " .. col .. ")")
            end
        end
    end
end

function MatrixBuilder:addFinderPatterns()
    local size = #self.matrix
    print("Adding finder patterns for size: " .. size)
    self:addFinderPattern(1, 1) -- Start at (1, 1) instead of (0, 0)
    self:addFinderPattern(1, size - 6) -- Adjusted for 1-based indexing
    self:addFinderPattern(size - 6, 1) -- Adjusted for 1-based indexing
end

function MatrixBuilder:addSeparators()
    local size = #self.matrix
    for i = 1, 8 do -- Adjusted for 1-based indexing
        self.matrix[8][i] = 0
        self.filled[8][i] = true

        self.matrix[i][8] = 0
        self.filled[i][8] = true

        self.matrix[8][size - i + 1] = 0
        self.filled[8][size - i + 1] = true

        self.matrix[i][size - 7] = 0
        self.filled[i][size - 7] = true

        self.matrix[size - 7][i] = 0
        self.filled[size - 7][i] = true

        self.matrix[size - i + 1][8] = 0
        self.filled[size - i + 1][8] = true
    end
end
function MatrixBuilder:addTimingPatterns()
    local size = #self.matrix
    for i = 9, size - 8 do -- Adjusted for 1-based indexing
        if i % 2 == 1 then
            self.matrix[7][i] = 1
            self.filled[7][i] = true

            self.matrix[i][7] = 1
            self.filled[i][7] = true
        else
            self.matrix[7][i] = 0
            self.filled[7][i] = true

            self.matrix[i][7] = 0
            self.filled[i][7] = true
        end
    end
end

function MatrixBuilder:addDarkModule(version)
    self.matrix[(4 * version) + 10][9] = 1 -- Adjusted for 1-based indexing
    self.filled[(4 * version) + 10][9] = true
end

function MatrixBuilder:addAlignmentPatterns(version)
    if version < 2 then return end
    local alignmentPositions = getAlignmentPositions(version)
    for _, row in ipairs(alignmentPositions) do
        for _, col in ipairs(alignmentPositions) do
            if not isInFinderPatternArea(row, col, #self.matrix) then
                self:addAlignmentPattern(row, col)
            end
        end
    end
end

function isInFinderPatternArea(row, col, size)
    -- Adjust for 1-based indexing
    return (row <= 8 and col <= 8) or (row <= 8 and col >= size - 7) or (row >= size - 7 and col <= 8)
end

function MatrixBuilder:addAlignmentPattern(centerRow, centerCol)
    for i = -2, 2 do
        for j = -2, 2 do
            local row = centerRow + i
            local col = centerCol + j
            -- Check if indices are within bounds (1-based indexing)
            if row >= 1 and row <= #self.matrix and col >= 1 and col <= #self.matrix[1] then
                if math.abs(i) == 2 or math.abs(j) == 2 or (i == 0 and j == 0) then
                    self.matrix[row][col] = 1
                    self.filled[row][col] = true
                else
                    self.matrix[row][col] = 0
                    self.filled[row][col] = true
                end
            else
                print("Index out of bounds: (" .. row .. ", " .. col .. ")")
            end
        end
    end
end

function getAlignmentPositions(version)
    -- Adjust positions for 1-based indexing by adding 1 to each position
    if version == 2 then return {7, 19} end
    if version == 3 then return {7, 23} end
    if version == 4 then return {7, 27} end
    if version == 5 then return {7, 31} end
    if version == 6 then return {7, 35} end
    if version == 7 then return {7, 23, 39} end
    if version == 8 then return {7, 25, 43} end
    if version == 9 then return {7, 27, 47} end
    if version == 10 then return {7, 29, 51} end
    if version == 11 then return {7, 31, 55} end
    if version == 12 then return {7, 33, 59} end
    if version == 13 then return {7, 35, 63} end
    if version == 14 then return {7, 27, 47, 67} end
    if version == 15 then return {7, 27, 49, 71} end
    if version == 16 then return {7, 27, 51, 75} end
    if version == 17 then return {7, 31, 55, 79} end
    if version == 18 then return {7, 31, 57, 83} end
    if version == 19 then return {7, 31, 59, 87} end
    if version == 20 then return {7, 35, 63, 91} end
    if version == 21 then return {7, 29, 51, 73, 95} end
    if version == 22 then return {7, 27, 51, 75, 99} end
    if version == 23 then return {7, 31, 55, 79, 103} end
    if version == 24 then return {7, 29, 55, 81, 107} end
    if version == 25 then return {7, 33, 59, 85, 111} end
    if version == 26 then return {7, 31, 59, 87, 115} end
    if version == 27 then return {7, 35, 63, 91, 119} end
    if version == 28 then return {7, 27, 51, 75, 99, 123} end
    if version == 29 then return {7, 31, 55, 79, 103, 127} end
    if version == 30 then return {7, 27, 53, 79, 105, 131} end
    if version == 31 then return {7, 31, 57, 83, 109, 135} end
    if version == 32 then return {7, 35, 61, 87, 113, 139} end
    if version == 33 then return {7, 31, 59, 87, 115, 143} end
    if version == 34 then return {7, 35, 63, 91, 119, 147} end
    if version == 35 then return {7, 31, 55, 79, 103, 127, 151} end
    if version == 36 then return {7, 25, 51, 77, 103, 129, 155} end
    if version == 37 then return {7, 29, 55, 81, 107, 133, 159} end
    if version == 38 then return {7, 33, 59, 85, 111, 137, 163} end
    if version == 39 then return {7, 27, 55, 83, 111, 139, 167} end
    if version == 40 then return {7, 31, 59, 87, 115, 143, 171} end
    return {}
end

function MatrixBuilder:addReservedAreas(version, size)
    -- Mark the horizontal separator below the top-right finder pattern
    for i = 1, 8 do -- Adjusted for 1-based indexing
        self.filled[9][size - 8 + i] = true
    end

    -- Mark the vertical separator to the left of the bottom-left finder pattern
    for i = (4 * version) + 11, size do -- Adjusted for 1-based indexing
        self.filled[i][9] = true
    end

    -- Mark the horizontal separator above the top-left finder pattern
    for i = 1, 8 do -- Adjusted for 1-based indexing
        self.filled[9][i] = true
    end

    -- Mark the vertical separator to the right of the top-left finder pattern
    for i = 1, 9 do -- Adjusted for 1-based indexing
        self.filled[i][9] = true
    end

    -- Mark the intersection of the separators
    self.filled[8][8] = true
   
    -- For versions greater than 7, mark the reserved areas for version information
    if version > 7 then
        -- Mark the bottom-left reserved area
        for i = size - 10, size - 8 do -- Adjusted for 1-based indexing
            for j = 1, 6 do -- Adjusted for 1-based indexing
                self.filled[i][j] = true
            end
        end
       
        -- Mark the top-right reserved area
        for i = 1, 6 do -- Adjusted for 1-based indexing
            for j = size - 10, size - 8 do -- Adjusted for 1-based indexing
                self.filled[i][j] = true
            end
        end
    end
end

function MatrixBuilder:fill(startRow, startCol, startIndex, startUp, maxBits)
    local row = startRow
    local col = startCol
    local index = startIndex
    local up = startUp
    local isAfterTiming = false
    local bitsPlaced = 0

    for iteration = 1, maxBits do
        local skipLoopIncrement = false

        -- Exit conditions
        if col < 1 or index > (isAfterTiming and #self.message - 1 or #self.message) then
            break
        end
        if maxBits ~= -1 and bitsPlaced >= maxBits then
            break
        end

        local bit = tonumber(self.message:sub(index, index))

        if isAfterTiming then
            if up then
                -- Upward movement after timing
                if not self.filled[row][col] then
                    self:placeBitInPos(row, col, bit)
                    self.filled[row][col] = true
                    bitsPlaced = bitsPlaced + 1
                else
                    index = index - 1
                end

                if row == 1 and (col % 2) ~= 0 then
                    up = false
                    col = col - 1
                    index = index + 1
                    skipLoopIncrement = true
                else
                    if (col % 2) == 0 then
                        col = col - 1
                    else
                        row = row - 1
                        col = col + 1
                    end
                end
            else
                -- Downward movement after timing
                if not self.filled[row][col] then
                    self:placeBitInPos(row, col, bit)
                    self.filled[row][col] = true
                    bitsPlaced = bitsPlaced + 1
                else
                    index = index - 1
                end

                if row == self.printSize and (col % 2) ~= 0 then
                    up = true
                    col = col - 1
                    index = index + 1
                    skipLoopIncrement = true
                else
                    if (col % 2) == 0 then
                        col = col - 1
                    else
                        row = row + 1
                        col = col + 1
                    end
                end
            end
        else
            if up then
                -- Upward movement before timing
                if not self.filled[row][col] then
                    self:placeBitInPos(row, col, bit)
                    self.filled[row][col] = true
                    bitsPlaced = bitsPlaced + 1
                else
                    index = index - 1
                end

                if row == 1 and (col % 2) == 0 then
                    up = false
                    if col == 8 then
                        isAfterTiming = true
                        col = col - 2
                    else
                        col = col - 1
                    end
                    index = index + 1
                    skipLoopIncrement = true
                else
                    if (col % 2) ~= 0 then
                        col = col - 1
                    else
                        row = row - 1
                        col = col + 1
                    end
                end
            else
                -- Downward movement before timing
                if not self.filled[row][col] then
                    self:placeBitInPos(row, col, bit)
                    self.filled[row][col] = true
                    bitsPlaced = bitsPlaced + 1
                else
                    index = index - 1
                end

                if row == self.printSize and (col % 2) == 0 then
                    up = true
                    if col == 8 then
                        isAfterTiming = true
                        col = col - 2
                    else
                        col = col - 1
                    end
                    index = index + 1
                    skipLoopIncrement = true
                else
                    if (col % 2) ~= 0 then
                        col = col - 1
                    else
                        row = row + 1
                        col = col + 1
                    end
                end
            end
        end

        -- Handle index increment
        if not skipLoopIncrement then
            index = index + 1
        end
    end
end

function MatrixBuilder:PlaceLastBit(size, bit, version)
  if version >= 7 then
    self:placeBitInPos(size - 11, 1, bit)
    self.filled[size - 11][1] = true
  else
    self:placeBitInPos(size - 8, 1, bit)
    self.filled[size - 8][1] = true
  end
end

function MatrixBuilder:placeBitInPos(row, col, bit)
  -- print("Row: " .. row .. "Col: " .. col)
  -- print(self.maskType)
    if self.maskType == 0 then
        if (row + col) % 2 == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 1 then
        if row % 2 == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 2 then
        if col % 3 == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 3 then
        if (row + col) % 3 == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 4 then
        if (math.floor(row / 2) + math.floor(col / 3)) % 2 == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 5 then
        if ((row * col) % 2) + ((row * col) % 3) == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 6 then
        if ((((row * col) % 2) + ((row * col) % 3)) % 2) == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    elseif self.maskType == 7 then
        if ((((row + col) % 2) + ((row * col) % 3)) % 2) == 0 then
            if bit == 1 then
                bit = 0
            elseif bit == 0 then
                bit = 1
            end
        end
        self.matrix[row][col] = bit
    else
        self.matrix[row][col] = bit
    end
end

function MatrixBuilder:addFormatInfo(version, size, ecLevel, maskType)
    self:addMaskAndECInfo(ecLevel, maskType, size)
    self:addVersionInfo(version, size)
end

function MatrixBuilder:addMaskAndECInfo(ecLevel, maskType, size)
    local formatString = ""

    if ecLevel < 0 or ecLevel > 3 then
        print("Invalid error correction level")
        return
    end
    if ecLevel == 0 then
        if maskType == 0 then
            formatString = formatInfo0[1]
        elseif maskType == 1 then
            formatString = formatInfo0[2]
        elseif maskType == 2 then
            formatString = formatInfo0[3]
        elseif maskType == 3 then
            formatString = formatInfo0[4]
        elseif maskType == 4 then
            formatString = formatInfo0[5]
        elseif maskType == 5 then
            formatString = formatInfo0[6]
        elseif maskType == 6 then
            formatString = formatInfo0[7]
        else
            print("invalid mask type")
            return
        end
    end

    if ecLevel == 1 then
        if maskType == 0 then
            formatString = formatInfo1[1]
            print("format string:" .. formatString)
        elseif maskType == 1 then
            formatString = formatInfo1[2]
            print("format string:" .. formatString)
        elseif maskType == 2 then
            formatString = formatInfo1[3]
            print("format string:" .. formatString)
        elseif maskType == 3 then
            formatString = formatInfo1[4]
            print("format string:" .. formatString)
        elseif maskType == 4 then
            formatString = formatInfo1[5]
            print("format string:" .. formatString)
        elseif maskType == 5 then
            formatString = formatInfo1[6]
            print("format string:" .. formatString)
        elseif maskType == 6 then
            formatString = formatInfo1[7]
            print("format string:" .. formatString)
        else
            print("invalid mask type")
            return
        end
    end

    if ecLevel == 2 then
        if maskType == 0 then
            formatString = formatInfo2[1]
            print("format string:" .. formatString)
        elseif maskType == 1 then
            formatString = formatInfo2[2]
            print("format string:" .. formatString)
        elseif maskType == 2 then
            formatString = formatInfo2[3]
            print("format string:" .. formatString)
        elseif maskType == 3 then
            formatString = formatInfo2[4]
            print("format string:" .. formatString)
        elseif maskType == 4 then
            formatString = formatInfo2[5]
            print("format string:" .. formatString)
        elseif maskType == 5 then
            formatString = formatInfo2[6]
            print("format string:" .. formatString)
        elseif maskType == 6 then
            formatString = formatInfo2[7]
            print("format string:" .. formatString)
        else
            print("invalid mask type")
            return
        end
    end

    if ecLevel == 3 then
        if maskType == 0 then
         
            formatString = formatInfo3[1]
            print("format string:" .. formatString)
        elseif maskType == 1 then
            formatString = formatInfo3[2]
            print("format string:" .. formatString)
        elseif maskType == 2 then
            formatString = formatInfo3[3]
            print("format string:" .. formatString)
        elseif maskType == 3 then
            formatString = formatInfo3[4]
            print("format string:" .. formatString)
        elseif maskType == 4 then
            formatString = formatInfo3[5]
            print("format string:" .. formatString)
        elseif maskType == 5 then
            formatString = formatInfo3[6]
            print("format string:" .. formatString)
        elseif maskType == 6 then
            formatString = formatInfo3[7]
            print("format string:" .. formatString)
        else
            print("invalid mask type")
            return
        end
    end

    if #formatString ~= 15 then
        error("Format string must be 15 bits long.")
    end

    self.matrix[9][1] = tonumber(formatString:sub(1, 1))
    self.matrix[9][2] = tonumber(formatString:sub(2, 2))
    self.matrix[9][3] = tonumber(formatString:sub(3, 3))
    self.matrix[9][4] = tonumber(formatString:sub(4, 4))
    self.matrix[9][5] = tonumber(formatString:sub(5, 5))
    self.matrix[9][6] = tonumber(formatString:sub(6, 6))
    self.matrix[9][8] = tonumber(formatString:sub(7, 7))
    self.matrix[9][9] = tonumber(formatString:sub(8, 8))
    self.matrix[8][9] = tonumber(formatString:sub(9, 9)) --
    self.matrix[6][9] = tonumber(formatString:sub(10, 10))
    self.matrix[5][9] = tonumber(formatString:sub(11, 11))
    self.matrix[4][9] = tonumber(formatString:sub(12, 12))
    self.matrix[3][9] = tonumber(formatString:sub(13, 13))
    self.matrix[2][9] = tonumber(formatString:sub(14, 14))
    self.matrix[1][9] = tonumber(formatString:sub(15, 15))

    self.matrix[size][9] = tonumber(formatString:sub(1, 1))
    self.matrix[size - 1][9] = tonumber(formatString:sub(2, 2))
    self.matrix[size - 2][9] = tonumber(formatString:sub(3, 3))
    self.matrix[size - 3][9] = tonumber(formatString:sub(4, 4))
    self.matrix[size - 4][9] = tonumber(formatString:sub(5, 5))
    self.matrix[size - 5][9] = tonumber(formatString:sub(6, 6))
    self.matrix[size - 6][9] = tonumber(formatString:sub(7, 7))
   
    self.matrix[9][size - 7] = tonumber(formatString:sub(8, 8))
    self.matrix[9][size - 6] = tonumber(formatString:sub(9, 9))
    self.matrix[9][size - 5] = tonumber(formatString:sub(10, 10))
    self.matrix[9][size - 4] = tonumber(formatString:sub(11, 11))
    self.matrix[9][size - 3] = tonumber(formatString:sub(12, 12))
    self.matrix[9][size - 2] = tonumber(formatString:sub(13, 13))
    self.matrix[9][size - 1] = tonumber(formatString:sub(14, 14))
    self.matrix[9][size] = tonumber(formatString:sub(15, 15))
end

function MatrixBuilder:addVersionInfo(version, size)
    if version < 7 then return end

    local vfString = versionFormats[version]:reverse()
    print("version format: "..versionFormats[version])

    self.matrix[1][size - 10] = tonumber(vfString:sub(1, 1))
    self.matrix[1][size - 9] = tonumber(vfString:sub(2, 2))
    self.matrix[1][size - 8] = tonumber(vfString:sub(3, 3))
    self.matrix[2][size - 10] = tonumber(vfString:sub(4, 4))
    self.matrix[2][size - 9] = tonumber(vfString:sub(5, 5))
    self.matrix[2][size - 8] = tonumber(vfString:sub(6, 6))
    self.matrix[3][size - 10] = tonumber(vfString:sub(7, 7))
    self.matrix[3][size - 9] = tonumber(vfString:sub(8, 8))
    self.matrix[3][size - 8] = tonumber(vfString:sub(9, 9))
    self.matrix[4][size - 10] = tonumber(vfString:sub(10, 10))
    self.matrix[4][size - 9] = tonumber(vfString:sub(11, 11))
    self.matrix[4][size - 8] = tonumber(vfString:sub(12, 12))
    self.matrix[5][size - 10] = tonumber(vfString:sub(13, 13))
    self.matrix[5][size - 9] = tonumber(vfString:sub(14, 14))
    self.matrix[5][size - 8] = tonumber(vfString:sub(15, 15))
    self.matrix[6][size - 10] = tonumber(vfString:sub(16, 16))
    self.matrix[6][size - 9] = tonumber(vfString:sub(17, 17))
    self.matrix[6][size - 8] = tonumber(vfString:sub(18, 18))

    self.matrix[size - 10][1] = tonumber(vfString:sub(1, 1))
    self.matrix[size - 9][1] = tonumber(vfString:sub(2, 2))
    self.matrix[size - 8][1] = tonumber(vfString:sub(3, 3))
    self.matrix[size - 10][2] = tonumber(vfString:sub(4, 4))
    self.matrix[size - 9][2] = tonumber(vfString:sub(5, 5))
    self.matrix[size - 8][2] = tonumber(vfString:sub(6, 6))
    self.matrix[size - 10][3] = tonumber(vfString:sub(7, 7))
    self.matrix[size - 9][3] = tonumber(vfString:sub(8, 8))
    self.matrix[size - 8][3] = tonumber(vfString:sub(9, 9))
    self.matrix[size - 10][4] = tonumber(vfString:sub(10, 10))
    self.matrix[size - 9][4] = tonumber(vfString:sub(11, 11))
    self.matrix[size - 8][4] = tonumber(vfString:sub(12, 12))
    self.matrix[size - 10][5] = tonumber(vfString:sub(13, 13))
    self.matrix[size - 9][5] = tonumber(vfString:sub(14, 14))
    self.matrix[size - 8][5] = tonumber(vfString:sub(15, 15))
    self.matrix[size - 10][6] = tonumber(vfString:sub(16, 16))
    self.matrix[size - 9][6] = tonumber(vfString:sub(17, 17))
    self.matrix[size - 8][6] = tonumber(vfString:sub(18, 18))
end

function evaluateCondition1(matrix)
    local penalty = 0

    -- Check rows
    for _, row in ipairs(matrix) do
        penalty = penalty + evaluateLine(row)
    end

    -- Check columns
    for col = 1, #matrix[1] do
        local column = {}
        for row = 1, #matrix do
            column[row] = matrix[row][col]
        end
        penalty = penalty + evaluateLine(column)
    end

    return penalty
end

function evaluateLine(line)
    local penalty = 0
    local count = 1
    local current = line[1]

    for i = 2, #line do
        if line[i] == current then
            count = count + 1
            if count == 5 then
                penalty = penalty + 3
            elseif count > 5 then
                penalty = penalty + 1
            end
        else
            current = line[i]
            count = 1
        end
    end

    return penalty
end

function evaluateCondition2(matrix)
    local penalty = 0

    -- Iterate through the matrix to find 2x2 blocks
    for row = 1, #matrix - 1 do
        for col = 1, #matrix[1] - 1 do
            -- Check if the current 2x2 block has the same color
            if matrix[row][col] == matrix[row][col + 1] and
               matrix[row][col] == matrix[row + 1][col] and
               matrix[row][col] == matrix[row + 1][col + 1] then
                penalty = penalty + 3 -- Add penalty for each 2x2 block
            end
        end
    end

    return penalty
end

function evaluateCondition3(matrix)
    local penalty = 0

    -- Define the two patterns to look for
    local pattern1 = {1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0}
    local pattern2 = {0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1}

    -- Check rows for the patterns
    for _, row in ipairs(matrix) do
        penalty = penalty + countPatternInLine(row, pattern1)
        penalty = penalty + countPatternInLine(row, pattern2)
    end

    -- Check columns for the patterns
    for col = 1, #matrix[1] do
        local column = {}
        for row = 1, #matrix do
            column[row] = matrix[row][col]
        end
        penalty = penalty + countPatternInLine(column, pattern1)
        penalty = penalty + countPatternInLine(column, pattern2)
    end

    return penalty
end

function countPatternInLine(line, pattern)
    local penalty = 0
    local patternLength = #pattern

    -- Slide the pattern over the line
    for i = 1, #line - patternLength + 1 do
        local match = true
        for j = 1, patternLength do
            if line[i + j - 1] ~= pattern[j] then
                match = false
                break
            end
        end
        if match then
            penalty = penalty + 40 -- Add penalty for each match
        end
    end

    return penalty
end

function evaluateCondition4(matrix)
    local totalModules = #matrix * #matrix[1]
    local darkModules = 0

    -- Count the number of dark modules (1 represents dark)
    for _, row in ipairs(matrix) do
        for _, module in ipairs(row) do
            if module == 1 then
                darkModules = darkModules + 1
            end
        end
    end

    -- Calculate the percentage of dark modules
    local darkPercent = (darkModules / totalModules) * 100

    -- Find the previous and next multiples of 5
    local prevMultiple = math.floor(darkPercent / 5) * 5
    local nextMultiple = prevMultiple + 5

    -- Calculate the absolute differences from 50
    local diffPrev = math.abs(prevMultiple - 50)
    local diffNext = math.abs(nextMultiple - 50)

    -- Divide by 5 and take the smaller result
    local penaltyPrev = math.floor(diffPrev / 5)
    local penaltyNext = math.floor(diffNext / 5)
    local penalty = math.min(penaltyPrev, penaltyNext) * 10

    return penalty
end

function calculatePenalty(maskedMatrix)
    return (evaluateCondition1(maskedMatrix) + evaluateCondition2(maskedMatrix) + evaluateCondition3(maskedMatrix) + evaluateCondition4(maskedMatrix))
end

-- main()