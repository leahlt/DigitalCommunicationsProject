module stringTobin(string, binString);
input [64*8-1:0] string;
output [64*8-1:0] binString;

wire [7:0] bin1, bin2, bin3, bin4, bin5, bin6, bin7, bin8, bin9, bin10, bin11, bin12, bin13, bin14, bin15, bin16, bin17, bin18, bin19, bin20, bin21, bin22, bin23, bin24, bin25, bin26, bin27, bin28, bin29;
wire [7:0] bin30, bin31, bin32, bin33, bin34, bin35, bin36, bin37, bin38, bin39, bin40, bin41, bin42, bin43, bin44, bin45, bin46, bin47, bin48, bin49, bin50, bin51, bin52, bin53, bin54, bin55, bin56, bin57;
wire [7:0] bin58, bin59, bin60, bin61, bin62, bin63, bin64;


textToBin one(string[511:504], bin1);
textToBin two(string[503:496], bin2);
textToBin three(string[495:488], bin3);
textToBin four(string[487:480], bin4);
textToBin five(string[479:472], bin5);
textToBin six(string[471:464], bin6);
textToBin seven(string[463:456], bin7);
textToBin eight(string[455:448], bin8);
textToBin nine(string[447:440], bin9);
textToBin ten(string[439:432], bin10);
textToBin eleven(string[431:424], bin11);
textToBin twelve(string[423:416], bin12);
textToBin thirteen(string[415:408], bin13);
textToBin fourteen(string[407:400], bin14);
textToBin fifteen(string[399:392], bin15);
textToBin sixteen(string[391:384], bin16);
textToBin seventeen(string[383:376], bin17);
textToBin eighteen(string[375:368], bin18);
textToBin nineteen(string[367:360], bin19);
textToBin twenty(string[359:352], bin20);
textToBin twentyone(string[351:344], bin21);
textToBin twentytwo(string[343:336], bin22);
textToBin twentythree(string[335:328], bin23);
textToBin twentyfour(string[327:320], bin24);
textToBin twentyfive(string[319:312], bin25);
textToBin twentysix(string[311:304], bin26);
textToBin twentyseven(string[303:296], bin27);
textToBin twentyeight(string[295:288], bin28);
textToBin twentynine(string[287:280], bin29);
textToBin thirty(string[279:272], bin30);
textToBin thirtyone(string[271:264], bin31);
textToBin thirtytwo(string[263:256], bin32);
textToBin thirtythree(string[255:248], bin33);
textToBin thirtyfour(string[247:240], bin34);
textToBin thirtyfive(string[239:232], bin35);
textToBin thirtysix(string[231:224], bin36);
textToBin thirtyseven(string[223:216], bin37);
textToBin thirtyeight(string[215:208], bin38);
textToBin thirtynine(string[207:200], bin39);
textToBin forty(string[199:192], bin40);
textToBin fortyone(string[191:184], bin41);
textToBin fortytwo(string[183:176], bin42);
textToBin fortythree(string[175:168], bin43);
textToBin fortyfour(string[167:160], bin44);
textToBin fortyfive(string[159:152], bin45);
textToBin fortysix(string[151:144], bin46);
textToBin fortyseven(string[143:136], bin47);
textToBin fortyeight(string[135:128], bin48);
textToBin fortynine(string[127:120], bin49);
textToBin fifty(string[119:112], bin50);
textToBin fiftyone(string[111:104], bin51);
textToBin fiftytwo(string[103:96], bin52);
textToBin fiftythree(string[95:88], bin53);
textToBin fiftyfour(string[87:80], bin54);
textToBin fiftyfive(string[79:72], bin55);
textToBin fiftysix(string[71:64], bin56);
textToBin fiftyseven(string[63:56], bin57);
textToBin fiftyeight(string[55:48], bin58);
textToBin fiftynine(string[47:40], bin59);
textToBin sixty(string[39:32], bin60);
textToBin sixtyone(string[31:24], bin61);
textToBin sixtytwo(string[23:16], bin62);
textToBin sixtythree(string[15:8], bin63);
textToBin sixtyfour(string[7:0], bin64);

assign binString = {bin1, bin2, bin3, bin4, bin5, bin6, bin7, bin8, bin9, bin10, bin11, bin12, bin13, bin14, bin15, bin16, bin17, bin18, bin19, bin20, bin21, bin22, bin23, bin24, bin25, bin26, bin27, bin28, bin29,
 bin30, bin31, bin32, bin33, bin34, bin35, bin36, bin37, bin38, bin39, bin40, bin41, bin42, bin43, bin44, bin45, bin46, bin47, bin48, bin49, bin50, bin51, bin52, bin53, bin54, bin55, bin56, bin57, bin58, bin59, bin60, bin61, bin62, bin63, bin64};

endmodule
