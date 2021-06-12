module text_top(input clk, input reset,  output [7:0] data_out);
    wire [7:0] source_text;
    wire [7:0] channel_data_out;
    wire [7:0] encrypted_txt;
    wire [7:0] decrypted_txt;
    get_text source(clk, reset, source_text);
    encrypt encryptor(clk, rst, 123, source_text, encrypted_txt, init_done);

    channel channel_mod(clk, reset, encrypted_txt, channel_data_out);
    decrypt decryptor(clk, rst, 123, channel_data_out, decrypted_txt, init_done);

    assign data_out = decrypted_txt;
    sink sinks(clk, reset, data_out);

endmodule