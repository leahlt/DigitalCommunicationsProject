module text_top(input clk, input reset, input [6:0] data_in, output [6:0] data_out);
    wire [7:0] source_text;
    wire [6:0] channel_data_out;
    wire [6:0] encrypted_txt;
    wire [6:0] decrypted_txt;

    wire err_corrected, err_detected, err_fatal;
    wire [6:0] mod_out;
    wire [6:0] demod_out;
    wire [6:0] rc4_in;
    assign rc4_in = data_in;
    encrypt encryptor(clk, rst, 123, rc4_in, encrypted_txt, init_done);
    BPSK modulator(encrypted_txt, mod_out,clk,  1);

    channel channel_mod(clk, reset, mod_out, channel_data_out);

    BPSK demodulator(channel_data_out, demod_out, clk, 1);

    decrypt decryptor(clk, rst, 123, demod_out, decrypted_txt, init_done);

    assign data_out = decrypted_txt;

endmodule