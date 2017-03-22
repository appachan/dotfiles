"use strict";
var vscode = require("vscode");
function scroll(line, position) {
    var currentPosition = vscode.window.activeTextEditor.selection.active;
    var moveToLine = currentPosition.line + line;
    var documentLineCount = vscode.window.activeTextEditor.document.lineCount;
    if (moveToLine > documentLineCount - 1) {
        moveToLine = documentLineCount - 1;
    }
    if (moveToLine < 0) {
        moveToLine = 0;
    }
    var moveToCharactor = vscode.window.activeTextEditor.document.lineAt(moveToLine).firstNonWhitespaceCharacterIndex;
    var newPosition = new vscode.Position(moveToLine, moveToCharactor);
    vscode.window.activeTextEditor.selection = new vscode.Selection(newPosition, newPosition);
    vscode.window.activeTextEditor.revealRange(vscode.window.activeTextEditor.selection, vscode.TextEditorRevealType.InCenter);
}
function activate(context) {
    var line1 = 30;
    var line2 = 60;
    var line3 = 90;
    function loadConfiguration() {
        var conf = vscode.workspace.getConfiguration("scrollkey");
        line1 = conf.get("line1", 30);
        line2 = conf.get("line2", 60);
        line3 = conf.get("line3", 90);
    }
    loadConfiguration();
    vscode.workspace.onDidChangeConfiguration(loadConfiguration);
    context.subscriptions.push(vscode.commands.registerCommand("scrollkey.up1", function () {
        scroll(-1 * line1, null);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("scrollkey.up2", function () {
        scroll(-1 * line2, null);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("scrollkey.up3", function () {
        scroll(-1 * line3, null);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("scrollkey.down1", function () {
        scroll(line1, null);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("scrollkey.down2", function () {
        scroll(line2, null);
    }));
    context.subscriptions.push(vscode.commands.registerCommand("scrollkey.down3", function () {
        scroll(line3, null);
    }));
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map