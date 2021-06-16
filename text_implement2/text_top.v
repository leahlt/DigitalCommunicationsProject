module text_top(input clk, input reset,/*input [7:0] data_in,*/ output [7:0] data_out);
    wire [7:0] source_text;
    wire [23:0] channel_data_out;
    wire [6:0] encrypted_txt;
    wire [6:0] decrypted_txt;
    wire [7:0] data_in;
    wire err_corrected, err_detected, err_fatal;
    wire [23:0] mod_out;
    wire [11:0] demod_out;
    wire [11:0] compressed_out;
    wire [11:0] hamming_enc;
    wire [11:0] hamming_dec;
    get_text source(clk, reset, data_in, init_done);
    compression compress(data_in, compressed_out);
    encrypt encryptor(clk, rst, 123, compressed_out, encrypted_txt, init_done);

    HammingIP_Enc hamming_encoder(encrypted_txt, hamming_enc);
BPSK_mod modulator(hamming_enc, mod_out);
    channel channel_mod(clk, reset, mod_out, channel_data_out);

    BPSK_demod demodulator(channel_data_out, demod_out);
    HammingIP_Dec hamming_decoder(channel_data_out,err_corrected,err_detected,err_fatal,hamming_dec);
    decrypt decryptor(clk, rst, 123, demod_out, decrypted_txt, init_done);
    decompression decompressd(decrypted_txt, data_out);
    sink finish(clk, reset, data_out, init_done);


endmodule

