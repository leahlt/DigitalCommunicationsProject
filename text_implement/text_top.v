module text_top(input clk, input reset, output [7:0] data_out);
    wire [7:0] source_text;
    wire [6:0] channel_data_out;
    wire [6:0] encrypted_txt;
    wire [6:0] decrypted_txt;
    wire [7:0] data_in;
    wire err_corrected, err_detected, err_fatal;
    wire [6:0] mod_out;
    wire [6:0] demod_out;
    wire [6:0] compressed_out;

    get_text source(clk, reset, data_in);
    compression compress(data_in, compressed_out);
    encrypt encryptor(clk, rst, 123, compressed_out, encrypted_txt, init_done);
    BPSK modulator(encrypted_txt, mod_out,clk,  1);

    channel channel_mod(clk, reset, mod_out, channel_data_out);

    BPSK demodulator(channel_data_out, demod_out, clk, 1);

    decrypt decryptor(clk, rst, 123, demod_out, decrypted_txt, init_done);
    decompression decompressd(decrypted_txt, data_out);
    sink finish(clk, reset, data_out);


endmodule