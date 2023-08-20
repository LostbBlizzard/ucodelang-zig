const std = @import("std");

//Native UCode
const uc = @cImport({
    @cInclude("UCodeLangCAPI.h");
});

pub fn UCodeLangInit() void {
    uc.UCodeLangCAPI_Init();
}
pub fn UCodeLangDeinit() void {
    uc.UCodeLangCAPI_DeInit();
}

test "Lib init and deinit" {
    UCodeLangInit();

    UCodeLangDeinit();
}
