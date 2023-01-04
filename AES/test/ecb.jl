using AES, Test

k = [0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c]
key = AES128Key(k)

plaintext = "The quick brown fox jumps over the lazy dog."
plaintext8 = "The quick brown fox jumps over the 😴 dog."

cipher = AESCipher(;key_length=128, mode=AES.ECB, key=key)
ct = encrypt(plaintext, cipher)
pt = decrypt(ct, cipher)
ct8 = encrypt(plaintext8, cipher)
pt8 = decrypt(ct8, cipher)

ciphertext = [0x16, 0xfa, 0x65, 0x87, 0x31, 0x00, 0x2a, 0xd6,
			  0xe3, 0x4a, 0x2f, 0xa0, 0x0f, 0x29, 0x0d, 0x9f,
			  0x97, 0x4f, 0x7b, 0xac, 0x10, 0x45, 0x57, 0x4b,
			  0x74, 0xc2, 0x04, 0x9e, 0x65, 0xd2, 0xa8, 0x89,
			  0x41, 0x37, 0xa2, 0x65, 0xbb, 0xb0, 0x1b, 0x60,
			  0x88, 0x95, 0x89, 0x9d, 0x38, 0x1e, 0xe7, 0x36]

@testset "ASCII" begin
	@test pt == transcode(UInt8,plaintext)
	@test ct.data == ciphertext
end

@testset "UTF-8" begin
	@test pt8 == transcode(UInt8,plaintext8)
end