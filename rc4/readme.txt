Encryption block:
encrypt(clk, rst, password, data_in, data_out, init_done, start, done);
Decryption block:
decrypt(clk, rst, password, data_in, data_out, init_done, start, done);

Inputs: 
Clk, rst, init_done, 

The encryption/decryption blocks require a setup time, the setup is finished once init_done is asserted.
The blocks operate on 2 control signals. Assert rdy to start encryption/decryption and assert done to stop encryption/decrpytion.
rc4_top tests the encryption/decryption by storing encrypted data in an array which is then decrypted once start is asserted for decryption;
