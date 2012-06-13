// @file
// @brief 初期化スクリプト

import mx.core.FlexGlobals;
import flash.events.KeyboardEvent;
import flash.events.Event;

// Main.mxml creationComplete="" から呼ばれる
private function onCreationComplete():void
{
	// キーボードイベントを取得
	FlexGlobals.topLevelApplication.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
	
	// 初期フォーカスの設定
	// html-template\index.template.html 側にもfocus設定が必要
	operation.setFocus();
}

// キーイベントハンドラ
private function keyHandler(event:KeyboardEvent):void {
	var key:String = numToChar(event.charCode);
	trace(event.keyCode + "/" + event.charCode + "/" + key);
	if(event.charCode == 8){
		// back
		calcHandlers.delNumber();
	}else if(event.charCode == 13){
		// enter
		calcHandlers.doOperation();
	}else if(event.charCode == 27){
		// esc
		calcHandlers.clearAll();
	}else if(event.charCode == 127){
		// del
		calcHandlers.clearEntry();
	}else if(key == '+'
		|| key == '-'
		|| key == '*'
		|| key == '/'
	){
		// 四則演算
		calcHandlers.setOperation(key)
	}else if ( (event.charCode > 47 && event.charCode < 58)
		|| key == '.') { // 数値
		calcHandlers.addNumber(key);
	}
}

// キー数値から文字に変換
private function numToChar(num:int):String {
	if(num >= 32 && num <= 47){
		// スペース ～ /
		var strKigou:String = " !\"#$%&'()*+,-./";
		return strKigou.charAt(num - 32);
	}else if (num > 47 && num < 58) {
		var strNums:String = "0123456789";
		return strNums.charAt(num - 48);
	} else if (num > 64 && num < 91) {
		var strCaps:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		return strCaps.charAt(num - 65);
	} else if (num > 96 && num < 123) {
		var strLow:String = "abcdefghijklmnopqrstuvwxyz";
		return strLow.charAt(num - 97);
	} else {
		return num.toString();
	}
}        

import flash.system.System;
import mx.controls.Alert;
import mx.events.MenuEvent;

// メニュークリックイベント
private function onClickMenuItem(event:MenuEvent):void {
	var sel:Object = event.item;
	var sel_id:String = sel.@id;
	var sel_label:String = event.label;
	if (sel_id =="") return;
	
	switch(sel_id){
		case 'menuCopy':
			// 結果をコピー
			System.setClipboard(calcHandlers.getDisplay());
			break;
		default:
			break;
	}
	//			Alert.show(sel_id + "を選択しましたね。");
}