/**
 * Calculator Controller
 * 
 * flex3からはpackage指定が必要
 * エラー「source-path のファイルには、外部から可視的な定義が必要です。ファイル内の定義が外部から可視的であることを意図している場合は、パッケージ内に定義を配置してください。」
*/
package {
	class CalculatorHandlers
	{
	    // プロパティ
	    // ビューオブジェクトへの参照を保持するためのオブジェクト
	    public var calcView:Object;
	    // 演算処理待ちの一時的な値を保持するためのレジスタ
	    private var reg1:String="";
	    private var reg2:String="";
	    // 演算処理の結果
	    private var result:Number;
	    // 現在使用中のレジスタの名前
	    private var currentRegister:String="reg1";
	    // 次に処理する演算の名前
	    private var operation:String="none";
	    // レジスタの文字列値を数値に変換して保持
	    private var r1:Number;
	    private var r2:Number;

		// コンストラクタ関数
	    public function CalculatorHandlers()
		{
		}
	
	    // メソッド
	    // 2 つのレジスタに対して現在の指定演算を実行
	    public function doOperation():void
		{
	        // レジスタの値を数値型に成型
	        r1=Number(reg1);
	        r2=Number(reg2);
	        switch (operation)
	        {
				case "+":
	            case "add":
	                result=r1+r2;
	                resetAfterOp();
	                break;
				case "-":
	            case "subtract":
	                result=r1-r2;
	                resetAfterOp();
	                break;
				case "*":
	            case "multiply":        
	                result=r1*r2;
	                resetAfterOp();
	                break;
				case "/":
	            case "divide":
	                result=r1/r2;
	                resetAfterOp();
	                break;
	            default:
					break;
	        }
	    }
	    // 現在のレジスタの値に数字を付加
	    public function addNumber(n:String):void
	    {
	        if (operation=="none" && currentRegister=="reg2")
	        {
	            reg1="";
	            setCurrentRegister();
	        }
	        this[currentRegister]+=n;
	        setDisplay(currentRegister);
			trace(this[currentRegister]);
	    }

		// 一桁削除する
		public function delNumber():void
		{
			var len:Number = this[currentRegister].toString().length;
			if(len <= 0) return;
			
			// 1桁削除
			this[currentRegister] = this[currentRegister].toString().substr(0, len-1);
			setDisplay(currentRegister);
		}
		
		// 現在のレジスタをクリア
	    public function clearEntry():void
	    {
	        this[currentRegister]="";
	        setDisplay(currentRegister);
	    }
	    // 2 つのレジスタと現在の指定演算をクリア
	    public function clearAll():void
	    {
	        reg1="";
	        reg2="";
	        setCurrentRegister();
	        setOperation("none");
	        setDisplay(currentRegister);
	    }
		
	    // 現在の指定演算を設定
	    public function setOperation(operation:String):void
	    {
	        this.operation=operation;
	        setCurrentRegister();
	    }
	    // ディスプレイに表示される値を設定
	    private function setDisplay(register:String):void
	    {
	        calcView.calcDisplay.text = this[register];
	    }
		
		// ディスプレイの値を取得
		public function getDisplay():String
		{
			return calcView.calcDisplay.text;
		}
		
	    // 現在のレジスタがどちらのレジスタであるかを設定
	    private function setCurrentRegister():void
	    {
	        if (reg1=="")
	        {
	            currentRegister="reg1";
	        }
	        else
	        {
	            currentRegister="reg2";
	        }
	    }
	    // 演算処理後に値をリセット
	    private function resetAfterOp():void
	    {
	        reg1=String(result);
	        reg2="";
	        setDisplay("reg1");
	        setOperation("none");
	    }
	}
}