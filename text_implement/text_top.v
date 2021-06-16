module text_top(input CLOCK_50, input reset, input wire [3:0] KEY, output [7:0] data_out);
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
    wire start_write;
    wire start_read;
    get_text source(CLOCK_50, reset, data_in, start_read, init_done);
    compression compress(data_in, compressed_out);
    encrypt encryptor(CLOCK_50, rst, 123, compressed_out, encrypted_txt, init_done);

    HammingIP_Enc hamming_encoder(encrypted_txt, hamming_enc);
    BPSK_mod_text modulator(hamming_enc, mod_out);

    channel channel_mod(CLOCK_50, reset, mod_out, channel_data_out);

    BPSK_demod_text demodulator(channel_data_out, demod_out);
    HammingIP_Dec hamming_decoder(channel_data_out,err_corrected,err_detected,err_fatal,hamming_dec);
    decrypt decryptor(CLOCK_50, rst, 123, demod_out, decrypted_txt, init_done);
    decompression decompressd(decrypted_txt, data_out);
    sink finish(CLOCK_50, reset, data_out, start_write, init_done);

    reg [2:0] c_state = 0;
    reg [2:0] n_state = 0;
    always @(*) begin
      case (c_state)
      0 : begin
        if(!KEY[0]) n_state = 1;

        else n_state = 0;
        //n_state = 1;
      end
      1 : begin
        n_state = 1;
      end
      default: n_state = 0;
    endcase
    end
    always @ (posedge CLOCK_50) begin
        if(reset) c_state <= 0;
        else c_state <= n_state;
    end

    assign start_read = (c_state == 1);
    assign start_write = (c_state == 1);


endmodule